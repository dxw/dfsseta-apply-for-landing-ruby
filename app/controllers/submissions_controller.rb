# frozen_string_literal: true

class SubmissionsController < ApplicationController
  def create
    @submission_reference = "AFL-123-ABC"
    render "successful_submission"
  end
end
