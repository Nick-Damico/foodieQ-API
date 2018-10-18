# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :server do
  desc "start development server"
  task :dev do
    sh 'rails s -p 3001'
  end
end
