# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.3.6"

gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", ">= 4.3.1"
gem "coffee-rails", "~> 5.0"
gem "high_voltage"
gem "jbuilder", "~> 2.11"
gem "jquery-rails"
gem "lograge", "~> 0.12"
gem "pg"
gem "pry-rails"
gem "pry-byebug"
gem "mini_racer"
gem "puma", "~> 6.0"
gem "rollbar"
gem "rails", "~> 7.2"
gem "sass-rails", "~> 6.0"
gem "turbolinks", "~> 5"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "govuk_design_system_formbuilder"
gem "govuk-components"
gem "terser"
gem "rswag-api"
gem "rswag-ui"
gem "seed-fu"
gem "devise", "~> 4.9"
gem "rails-controller-testing"

group :development do
  gem "better_errors"
  gem "listen", ">= 3.0.5", "< 3.10"
  gem "rails_layout"
  gem "web-console", ">= 3.3.0"
  gem "htmlbeautifier"
  gem "solargraph"
end

group :development, :test do
  gem "brakeman"
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "rswag-specs"
  gem "standard"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "simplecov"
  gem "climate_control"
  gem "timecop"
end
