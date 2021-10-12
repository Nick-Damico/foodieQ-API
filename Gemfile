source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'
gem 'bootsnap', '~> 1.3', '>= 1.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rack-cors'
gem 'devise', '~> 4.5'
gem 'jwt', '~> 2.1'
gem 'active_model_serializers', '~> 0.10.8'
gem 'pagy', '~> 1.2', '>= 1.2.1'
gem "aws-sdk-s3", require: false
# gem 'mini_magick', '~> 4.9', '>= 4.9.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Use ActiveModel has_secure_password
# Use postgresql as the database for Active Record
# Use Puma as the app server
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'activeadmin', '~> 1.3', '>= 1.3.1'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop-rspec'
  gem 'pry'
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'faker', '~> 1.9', '>= 1.9.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
