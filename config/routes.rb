# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "health_check" => "application#health_check"
  root to: "pilots#start"

  devise_for :user

  namespace :stages do
    get :destination, to: "destination_stage#show"
    put :destination, to: "destination_stage#update"

    get :dates, to: "dates_stage#show"
    put :dates, to: "dates_stage#update"

    get :"registration-identifier", to: "registration_identifier_stage#show"
    put :"registration-identifier", to: "registration_identifier_stage#update"

    get :"personal-details", to: "personal_details_stage#show"
    put :"personal-details", to: "personal_details_stage#update"

    get :"check-your-answers", to: "check_your_answers_stage#show"
    put :"check-your-answers", to: "check_your_answers_stage#update"
  end

  namespace :officer do
    resources :landing_applications, path: "landing-applications", only: :index do
      resources :decisions, only: [:new, :create]
    end
  end

  namespace :api do
    get :"landing-applications", to: "landing_applications#index"
  end

  resource :submissions, only: :create

  # If the CANONICAL_HOSTNAME env var is present, and the request doesn't come from that
  # hostname, redirect us to the canonical hostname with the path and query string present
  if ENV["CANONICAL_HOSTNAME"].present?
    constraints(host: Regexp.new("^(?!#{Regexp.escape(ENV["CANONICAL_HOSTNAME"])})")) do
      match "/(*path)" => redirect(host: ENV["CANONICAL_HOSTNAME"]), :via => [:all]
    end
  end
end
