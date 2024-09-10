RSpec.describe User do
  describe "has_many *assessed_applications* association" do
    it "has a #assessed_application association" do
      user = FactoryBot.create(:user)

      application = FactoryBot.create(:landing_application, assessor: user)

      user.assessed_applications = [application]

      user.save!

      user.reload

      expect(user.assessed_applications.first).to eq(application)
    end
  end
end
