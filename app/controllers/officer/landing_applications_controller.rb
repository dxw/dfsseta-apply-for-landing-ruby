# frozen_string_literal: true

class Officer::LandingApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @landing_applications = LandingApplication
      .includes(:destination)
      .order(application_submitted_at: :desc)
  end
end
