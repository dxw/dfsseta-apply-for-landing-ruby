# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def create
    @submission_reference = SubmissionsReferenceGenerator.generate

    SubmissionsProcessor
      .new(reference: @submission_reference, session: session)
      .call

    render "successful_submission"
  end
end
