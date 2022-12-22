# frozen_string_literal: true

module Manage
  module Settings
    class VesselsController < BaseController
      include OrganizationScoped

      def new
        @vessel = scope.build
        authorize([:manage, :settings, @vessel])
      end

      def create
        @vessel = scope.build(vessel_params)
        authorize([:manage, :settings, @vessel])

        if @vessel.save
          redirect_to edit_manage_organization_settings_meta_data_path, flash: { success: "Vessel added" }
        else
          render "new", flash: { danger: "There were issues adding the vessel" }
        end
      end

      def edit
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])
      end

      def update
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])

        if @vessel.update(vessel_params)
          redirect_to edit_manage_organization_settings_meta_data_path, flash: { success: "Vessel updated" }
        else
          render "edit", flash: { danger: "There were issues updating the vessel" }
        end
      end

      def destroy
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])

        if @vessel.destroy
          redirect_back fallback_location: edit_manage_organization_settings_meta_data_path,
                        flash: { success: "Vessel removed!" }
        else
          render "edit", flash: { danger: "There were issues removing the vessel" }
        end
      end
      
      # New code start #
      def display_modal # bad action name. Cant think of a better one
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])
        @employees = @vessel.employments
        @available_vessels = scope.where.not(id: @vessel.id)
      end

      def move_employees
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])

        @employees = @vessel.employments
        @new_vessel = scope.find_by(name: params[:new_vessel])
        # no check for @new_vessel since :new_vessel is required
        move_employees_helper(@employees, @new_vessel)
        @vessel.destroy
        redirect_to edit_manage_organization_settings_meta_data_path, 
                         flash: { success: "Employees moved, Vessel removed" }
        ## works fine but rubocop cries Metrics/AbcSize too high
        # if @vessel.destroy
        #   redirect_to edit_manage_organization_settings_meta_data_path, 
        #                 flash: { success: "Employees moved, Vessel removed" }
        # else
        #   redirect_back fallback_location: edit_manage_organization_settings_meta_data_path,
        #                 flash: { danger: "There were issues moving the employees" }
        # end
      end
      def move_employees_helper(employees, new_vessel)
        employees.each do |employee|
          employee.update(vessel_id: new_vessel.id)
        end
      end
      # New code end #
      
      private

      def scope
        policy_scope([:manage, :settings, Vessel])
      end

      def vessel_params
        params.require(:vessel).permit(:id, :name)
      end
    end
  end
end
