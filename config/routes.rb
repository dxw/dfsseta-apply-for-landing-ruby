# frozen_string_literal: true

Rails.application.routes.draw do
  get "health_check" => "application#health_check"
  root to: "pilots#start"

  namespace :stages do
    get :destination, to: "destination_stage#show"
    put :destination, to: "destination_stage#update"

    get :dates, to: "dates_stage#show"
    put :dates, to: "dates_stage#update"

    get :"registration-number", to: "registration_number_stage#show"
    put :"registration-number", to: "registration_number_stage#update"
  end

  # If the CANONICAL_HOSTNAME env var is present, and the request doesn't come from that
  # hostname, redirect us to the canonical hostname with the path and query string present
  if ENV["CANONICAL_HOSTNAME"].present?
    constraints(host: Regexp.new("^(?!#{Regexp.escape(ENV["CANONICAL_HOSTNAME"])})")) do
      match "/(*path)" => redirect(host: ENV["CANONICAL_HOSTNAME"]), :via => [:all]
    end
  end
end
