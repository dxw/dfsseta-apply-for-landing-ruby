# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.3.4"

gem "bootsnap", ">= 1.1.0", require: false
gem "high_voltage"
gem "jquery-rails"
gem "lograge", "~> 0.12"
gem "pg"
gem "pry-rails"
gem "pry-byebug"
gem "puma", "~> 6.0"
gem "rollbar"
gem "rails", "~> 7.0"
gem "sprockets-rails"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "jsbundling-rails"
gem "govuk_design_system_formbuilder"

group :development do
  gem "better_errors"
  gem "listen", ">= 3.0.5", "< 3.10"
  gem "rails_layout"
  gem "web-console", ">= 3.3.0"
end

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "standard"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "climate_control"
end
