# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc "Run all the tests"
task default: %i[spec rswag_api_tests_with_docs standard]

desc "Run Rswag API test with auto documentation"
task :rswag_api_tests_with_docs do
  # run the api specs with the Rswag formatter which creates
  # our OpenAPI spec
  system "bundle exec rspec " \
         "--pattern  'spec/api/**/*_spec.rb' " \
         "--format Rswag::Specs::SwaggerFormatter " \
         "--order defined"
end
