require "rails_helper"

RSpec.describe Api::LandingApplicationsController do
  describe "GET :index" do
    it "asks LandingApplicationEntity to represent each application" do
      app_1 = double("app1")
      app_2 = double("app2")

      entity_1 = instance_double(LandingApplicationEntity, represent: double)
      entity_2 = instance_double(LandingApplicationEntity, represent: double)

      allow(LandingApplication).to receive(:includes).and_return([app_1, app_2])

      allow(LandingApplicationEntity).to receive(:new).with(app_1).and_return(entity_1)
      allow(LandingApplicationEntity).to receive(:new).with(app_2).and_return(entity_2)

      get :index

      expect(entity_1).to have_received(:represent)
      expect(entity_2).to have_received(:represent)
    end
  end
end
