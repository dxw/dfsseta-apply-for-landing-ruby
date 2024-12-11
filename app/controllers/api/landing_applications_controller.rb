class Api::LandingApplicationsController < ApplicationController
  before_action :authenticate_api_key

  def index
    render json: LandingApplication.includes(:destination).map { |la|
      LandingApplicationEntity.new(la).represent
    }
  end

  private

  def authenticate_api_key
    head :unauthorized unless ApiClientAuthenticator.authenticate?(api_key)
  end

  def api_key
    request.headers["HTTP_X_API_KEY"]
  end
end
