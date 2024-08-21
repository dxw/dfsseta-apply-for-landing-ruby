class SubmissionsProcessor
  def initialize(reference:, session:, repository_class: LandingApplication)
    @repository_class = repository_class
    @reference = reference
    @session = session
  end

  def call
    @repository_class.create(
      destination
        .merge(reference)
        .merge(dates)
        .merge(registration_identifier)
        .merge(personal_details)
        .merge(submitted_at)
        .merge(blank_fields)
    )
  end

  private

  def destination
    {destination: LandableBody.find(@session.dig("destination", "destination_id"))}
  end

  def reference
    {application_reference: @reference}
  end

  def dates
    {
      landing_date: Date.parse(@session.dig("dates", "landing_date")),
      departure_date: Date.parse(@session.dig("dates", "departure_date"))
    }
  end

  def registration_identifier
    {
      spacecraft_registration_id: @session.dig(
        "registration_identifier",
        "registration_id"
      )
    }
  end

  def personal_details
    {
      pilot_name: @session.dig("personal_details", "fullname"),
      pilot_email: @session.dig("personal_details", "email"),
      pilot_licence_id: @session.dig("personal_details", "licence_id")
    }
  end

  def submitted_at
    {application_submitted_at: Time.now}
  end

  def blank_fields
    {
      application_decision: nil,
      application_decision_made_at: nil,
      permit_id: nil
    }
  end
end
