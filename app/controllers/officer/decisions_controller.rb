class Officer::DecisionsController < ApplicationController
  def new
    @application_decision = AssessmentDecisionForm.new(application_decision: nil)
  end

  def create
    application = LandingApplication.find(params[:landing_application_id])
    @application_decision = AssessmentDecisionForm.new(application_decision: params.dig(:assessment_decision_form, "application_decision"))

    application.application_decision = @application_decision.application_decision

    if @application_decision.valid?
      application.application_decision_made_at = Time.current
      application.assessor = current_user
      application.save
      redirect_to(officer_landing_applications_path)
    else
      render :new
    end
  end
end
