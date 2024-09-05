# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApplyForLandingRuby
  class Application < Rails::Application
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Alert if lazily loading records in order to guard against N+1 queries.
    # (we disable strict_loading if we're in a console session)
    # Individual environments specify whether to raise StrictLoadingViolationError:
    #   - raises in development and test
    #   - logs in production
    config.active_record.strict_loading_by_default = !["rails_console", "bin/rails"]
      .include?($PROGRAM_NAME)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Make sure the `form_with` helper generates local forms, instead of defaulting
    # to remote and unobtrusive XHR forms
    config.action_view.form_with_generates_remote_forms = false
  end
end
