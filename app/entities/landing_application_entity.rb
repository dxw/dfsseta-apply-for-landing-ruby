class LandingApplicationEntity
  def initialize(landing_application)
    @obj = landing_application
  end

  def represent
    {
      application_id: @obj.id,
      pilot: {
        name: @obj.pilot_name,
        email: @obj.pilot_email,
        licence_id: @obj.pilot_licence_id
      },
      permit_issued_at: @obj.application_decision_made_at.try(:iso8601, 0),
      permit_id: @obj.permit_id,
      destination: @obj.destination.name,
      landing_date: @obj.landing_date.try(:iso8601),
      departure_date: @obj.departure_date.try(:iso8601),
      spacecraft_registration_id: @obj.spacecraft_registration_id
    }
  end
end
