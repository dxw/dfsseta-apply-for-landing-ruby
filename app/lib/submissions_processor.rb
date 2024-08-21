class SubmissionsProcessor
  def initialize(reference:, session:, repository_class: LandingApplication)
    @repository_class = repository_class
    @reference = reference
    @session = session
  end

  def call
    @repository_class.create(
      destination: destination,
      pilot_name: @session.dig("personal_details", "fullname"),
      pilot_email: @session.dig("personal_details", "email"),
      pilot_licence_id: @session.dig("personal_details", "licence_id"),
      spacecraft_registration_id: @session.dig("registration_identifier", "registration_id"),
      landing_date: landing_date,
      departure_date: departure_date,
      application_reference: @reference,
      application_submitted_at: Time.now,
      application_decision: nil,
      application_decision_made_at: nil,
      permit_id: nil
    )
  end

  private

  def destination
    LandableBody.find(@session.dig("destination", "destination_id"))
  end

  def landing_date
    Date.parse(@session.dig("dates", "landing_date"))
  end

  def departure_date
    Date.parse(@session.dig("dates", "departure_date"))
  end
end
