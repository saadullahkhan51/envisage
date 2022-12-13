# Medtryck - Assessment
This repo contains a small portion of the assessment system and is used for recruitment purposes.
This system follows a lot of the same logic as the full system but with less complexity and less depth.

If you're seeing this readme you've most probably been asked to add a feature in the system or fix a bug, if so the description of the task has been sent to you elsewhere.

## Getting the system up an running
Hopefully you're able to get the system up and running through calling `bin/setup`.
If not, there are a few tasks that have to be completed first, documented in the checklist below.

- [ ] Make sure you have the right Ruby version installed, 2.6.3
  * If you're using rvm or rbenv you can usually run their install command and they will find the version from the `.ruby-version` file.
- [ ] Make sure you have the right Node version installed, v12.18.4
  * If you're using nvm you can usually install the version by running `nvm install` which fetches version from `.nvmrc`.
  * You might also need to run `nvm use` or similar.
- [ ] Install bundler if needed
  * Running the following usually does the trick `gem install bundler --conservative`.
  * rbenv has a handy `rbenv shell [version]` command that usually fixes permission issues.
- [ ] Install Yarn if not already available.
  * Most easily done by running `npm install --global yarn`
- [ ] Install gems with bundler
  * Easily handled by running: `bin/bundle install`.
- [ ] Install packages through yarn
  * This is done through running `bin/yarn install`.
  * You might need to run `nvm use` or similar if you're using a version manager.
- [ ] Create and migrate the DB
  * Can be done through running `bin/rails db:setup`.
  * Alternatively, `bin/rails db:create`, `bin/rails db:migrate`
- [ ] Run the server!
  * You're so close to the goal, just run `bin/rails s` and we're off!

## Seeding
Seeding data is handled through seedbank.
The base data can be seeded by running `bin/rails db:seed:development:base`.
This seed file is also included automatically when running `bin/rails db:reset`.

## Linting with eslint and rubocop
To make sure the code will pass future linting, the following tools exist.

**To lint the ruby code run:**
```
bin/bundle exec rubocop
```

## Task Description
One of the key features of Envisage is for organizations to be able to manage their crew. To their help they have some meta data models, one of which is called “Vessel”.

To manage their vessels the organization admins have a CRUD interface. To make this interface more powerful you’re going to expand on the ability to remove vessels, by allowing the admin to move all connected employees upon removal.
Brief list of changes that is needed:
- A new modal should be shown when clicking delete on a vessel.
  - The admin should have the option of just removing the vessel without moving employees.
  - The admin should have the option of moving employees to a different vessel.
- Routes, controller actions and model updates to support the behavior above.
