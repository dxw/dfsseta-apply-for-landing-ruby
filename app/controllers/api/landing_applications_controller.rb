class Api::LandingApplicationsController < ApplicationController
  def index
    render json: LandingApplication.includes(:destination).map { |la|
      LandingApplicationEntity.new(la).represent
    }
  end
end
