class DecisionsService
  def self.new(application_decision, application_id, assessor)
    application = LandingApplication.find(application_id)
    application.application_decision = application_decision
    application.application_decision_made_at = Time.current
    application.assessor = assessor
    if application_decision == "approved"
      application.permit_id = SecureRandom.uuid
    end
    application.save
  end
end
