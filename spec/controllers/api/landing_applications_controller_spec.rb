require "rails_helper"

RSpec.describe Api::LandingApplicationsController do
  describe "authentication with API Key" do
    it "asks the ApiClientAuthenticator to verify the API Key provided in a header" do
      allow(ApiClientAuthenticator).to receive(:authenticate?)

      request.env["HTTP_X_API_KEY"] = "abc123"
      get :index

      expect(ApiClientAuthenticator).to have_received(:authenticate?).with("abc123")
    end
  end

  describe "GET :index (with a valid API Key)" do
    before do
      allow(ApiClientAuthenticator).to receive(:authenticate?).and_return(true)
    end

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
