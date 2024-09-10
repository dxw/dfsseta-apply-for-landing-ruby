require "rails_helper"

RSpec.describe LandingApplicationEntity do
  let(:decision_timestamp) { Time.current + 1.week }
  let(:landing_date) { Date.today + 1.month }
  let(:departure_date) { Date.today + 1.month + 1.week }

  let(:landing_application) do
    LandingApplication.new(
      id: "f5f81284-e377-4017-aab1-1efac2119a2c",
      destination: LandableBody.new(name: "Planet X"),
      pilot_name: "Fred Smith",
      pilot_email: "fred@example.com",
      pilot_licence_id: "1233ABC00123",
      spacecraft_registration_id: "ABC123A",
      landing_date: landing_date,
      departure_date: departure_date,
      permit_id: "LP-3522-HNWD",
      application_decision_made_at: decision_timestamp
    )
  end

  describe "#represent" do
    let(:representation) do
      LandingApplicationEntity.new(landing_application).represent
    end

    it "presents the id as 'application_id'" do
      expect(representation.fetch(:application_id))
        .to eq("f5f81284-e377-4017-aab1-1efac2119a2c")
    end

    it "presents the permit_id" do
      expect(representation.fetch(:permit_id)).to eq("LP-3522-HNWD")
    end

    it "presents the pilot's properties in their own nested object" do
      expect(representation.fetch(:pilot))
        .to eq({
          email: "fred@example.com",
          name: "Fred Smith",
          licence_id: "1233ABC00123"
        })
    end

    it "presents the #application_decision_made_at as 'permit_issued_at'" do
      expect(representation.fetch(:permit_issued_at))
        .to eq(decision_timestamp.iso8601(0))
    end

    it "presents the destination name" do
      expect(representation.fetch(:destination)).to eq("Planet X")
    end

    it "presents the spacecraft_registration_id" do
      expect(representation.fetch(:spacecraft_registration_id)).to eq("ABC123A")
    end

    it "presents the landing and departure dates" do
      aggregate_failures do
        expect(representation.fetch(:landing_date)).to eq(landing_date.iso8601)
        expect(representation.fetch(:departure_date)).to eq(departure_date.iso8601)
      end
    end
  end
end
