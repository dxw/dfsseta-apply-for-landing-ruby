RSpec.describe SubmissionsProcessor do
  let(:time_now) { Time.now }

  before do
    Timecop.freeze(time_now)
  end

  after do
    Timecop.return
  end

  describe "#call" do
    let(:destination_finder) { class_double(LandableBody) }

    let(:repository_class) { class_double(LandingApplication) }
    let(:reference) { "AFL-123-ABC" }

    let(:destination) { FactoryBot.create(:landable_body, name: "Mars") }
    let(:landing_date) { "#{Date.today.year + 1}-10-10" }
    let(:departure_date) { "#{Date.today.year + 1}-10-17" }

    let(:session) do
      {
        "destination" => {
          "destination_id" => destination.id
        },
        "dates" => {
          "landing_date" => landing_date,
          "departure_date" => departure_date
        },
        "registration_identifier" => {
          "registration_id" => "ABC123A"
        },
        "personal_details" => {
          "fullname" => "Fred Daisy",
          "email" => "fred@goo.com",
          "licence_id" => "1233ABC00123"
        }
      }
    end

    it "retrieves the destination from LandingBody" do
      allow(repository_class).to receive(:create).and_return(double)
      allow(destination_finder).to receive(:find).and_return(double)

      SubmissionsProcessor.new(
        session: session,
        reference: reference,
        repository_class: repository_class,
        destination_finder: destination_finder
      ).call

      expect(destination_finder).to have_received(:find).with(destination.id)
    end

    it "creates a LandingApplication with the reference and data from session" do
      allow(repository_class).to receive(:create).and_return(double)

      SubmissionsProcessor.new(
        session: session,
        reference: reference,
        repository_class: repository_class
      ).call

      expect(repository_class).to have_received(:create).with(
        destination: destination,
        pilot_name: "Fred Daisy",
        pilot_email: "fred@goo.com",
        pilot_licence_id: "1233ABC00123",
        spacecraft_registration_id: "ABC123A",
        landing_date: Date.parse(landing_date),
        departure_date: Date.parse(departure_date),
        application_reference: reference,
        application_submitted_at: time_now,
        application_decision: nil,
        application_decision_made_at: nil,
        permit_id: nil
      )
    end
  end
end
