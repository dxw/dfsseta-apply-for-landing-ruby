# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def create
    @submission_reference = SubmissionsReferenceGenerator.generate
    render "successful_submission"
  end
end
