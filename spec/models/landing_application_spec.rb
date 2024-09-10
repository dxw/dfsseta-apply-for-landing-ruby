RSpec.describe LandingApplication do
  describe "belongs_to *assessor* association" do
    let(:assessor) { FactoryBot.create(:user) }

    it "has an #assessor association" do
      landing_application = FactoryBot.create(:landing_application, assessor: assessor)

      landing_application.assessor.reload

      expect(landing_application.assessor.id).to eq(assessor.id)
    end
  end
end
