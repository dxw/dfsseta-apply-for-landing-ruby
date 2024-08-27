# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def create
    landing_application = SubmissionsProcessor
      .new(reference: ApplicationReferenceGenerator.generate, session: session)
      .call

    @application_reference = landing_application.application_reference

    clear_application_from_session

    render "successful_submission"
  end

  private

  def clear_application_from_session
    AnswersRepository.new(session).clear_answers
  end
end
