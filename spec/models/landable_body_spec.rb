RSpec.describe LandableBody do
  describe "::active" do
    before do
      FactoryBot.create(:landable_body, name: "Uranus", active: true)
      FactoryBot.create(:landable_body, name: "Earth", active: true)
      FactoryBot.create(:landable_body, name: "Neptune", active: false)
    end

    let(:bodies) { LandableBody.active.map(&:name) }

    it "excludes records without the _active_ boolean flag" do
      aggregate_failures do
        expect(bodies).not_to include("Neptune")
        expect(bodies.count).to eq(2)
      end
    end

    it "orders the records by name" do
      expect(bodies).to eq(["Earth", "Uranus"])
    end
  end
end
