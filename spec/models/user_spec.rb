RSpec.describe User do
  describe "has_many *landing_applications* association" do
    it "has a #landing_application association" do
      user = FactoryBot.create(:user)

      application = FactoryBot.create(:landing_application, assessor: user)

      user.landing_applications = [application]

      user.save!

      user.reload

      expect(user.landing_applications.first).to eq(application)
    end
  end
end
