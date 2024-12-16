class AssessmentDecisionForm
  include ActiveModel::Model

  attr_accessor :application_decision, :application_decision_made_at

  def initialize(application_decision:)
    @application_decision = application_decision
  end

  validates :application_decision,
    presence: {
      message: "Select either 'Approve' or 'Deny'"
    }
end
