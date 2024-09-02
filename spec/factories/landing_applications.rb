FactoryBot.define do
  factory :landing_application do
    association(:destination, factory: :landable_body)
    pilot_email { "alan@nasa.org.uk" }
    pilot_name { "Alan Oliver" }
    pilot_licence_id { "1233ABC00123" }
    spacecraft_registration_id { "ABC123A" }
    landing_date { Date.tomorrow }
    departure_date { Date.tomorrow + 3 }
    application_reference { ApplicationReferenceGenerator.generate }
    application_submitted_at { Time.current }
  end
end
