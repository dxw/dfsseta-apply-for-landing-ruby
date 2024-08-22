# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def create
    landing_application = SubmissionsProcessor
      .new(reference: SubmissionsReferenceGenerator.generate, session: session)
      .call

    @submission_reference = landing_application.application_reference

    render "successful_submission"
  end
end
