# FoodieQ Rails 5 Api

## Ruby version
  ruby 2.3.3
  rails 5.1.6
  rails-rspec 3.8

## System dependencies
  ruby
  rails
  postgreSQL
  Bundler

## Install
  1. Make sure PostgreSQL is install and running on your system.
  2. Download this repo or run `git clone https://github.com/Nick-Damico/foodieQ-API`
  3. cd into foodieQ-API directory
  4. execute in terminal `bundle install`
  5. `rails db:create`
  6. `rails db:migrate`
  7. `rails db:seed`

## Database creation
  execute command `rails db:create`

## Database initialization
  execute command `rails db:migrate`

## How to run the test suite
  `rspec`
  `rspec specs/directory/##_spec.rb` file of your choice,
  example `rspec spec/requests/recipes_controller_spec.rb`

## Usage
  After following instructions for creation and initialization of db,
  you can make requests to the server now using curl or PostMan.

  Example: `curl -v http://localhost:3000/api/v1/recipes`

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions
