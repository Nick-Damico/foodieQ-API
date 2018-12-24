# FoodieQ Rails 5 Api

FoodieQ Api is built with Rails 5+ in --api only mode. It serves as the backend to
the client side React & Redux application Foodie-q. Using Active Model Serializer,
it formats data and responds with JSON formatted responses following suggested
best practices from [jsonapi.org](https://jsonapi.org).

The backend utilizes Devise gem along with JWT gem for authenticating and authorizing
users. Not all endpoints are protected, public requests can be made to the
backend for all recipes at `https://foodieq-api.herokuapp.com/api/v1/recipes`.

## Ruby version
  ruby 2.3.3 <br/>
  rails 5.2.0<br/>
  rails-rspec 3.8<br/>

## System dependencies
  ruby<br/>
  rails<br/>
  postgreSQL<br/>
  Bundler<br/>
  Pagy - for paginating Recipes, and Users on future update<br/>
  AMS  - for Serializing Resources and associated resources<br/>

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
