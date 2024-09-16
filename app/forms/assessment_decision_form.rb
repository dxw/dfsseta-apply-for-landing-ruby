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

  validate :ensure_decision_valid

  def ensure_decision_valid
    unless LandingApplication.application_decisions.key?(application_decision)
      errors.add(:application_decision, "Select either 'Approve' or 'Deny'")
    end
  end
end
