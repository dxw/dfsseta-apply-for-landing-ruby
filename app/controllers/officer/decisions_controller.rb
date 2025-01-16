class Officer::DecisionsController < ApplicationController
  def new
    @application_decision = AssessmentDecisionForm.new(application_decision: nil)
  end

  def create
    @application_decision = AssessmentDecisionForm.new(application_decision: params.dig(:assessment_decision_form, "application_decision"))

    if @application_decision.valid?
      DecisionsService.new(@application_decision.application_decision, params[:landing_application_id], current_user)
      redirect_to(officer_landing_applications_path)
    else
      render :new
    end
  end
end
