require "rails_helper"

RSpec.describe Officer::LandingApplicationsController, type: :controller do
  let(:officer) do
    FactoryBot.create(:user)
  end

  before { sign_in officer }

  describe "GET to :index" do
    context "when officer is signed in"
    it "retrieves the landing applications, newest first, with destinations loaded" do
      ar_query = double("query", order: double)
      allow(LandingApplication).to receive(:includes).and_return(ar_query)

      get :index

      expect(response).to have_http_status(:success)
      expect(LandingApplication).to have_received(:includes).with(:destination)
      expect(ar_query).to have_received(:order).with(application_submitted_at: :desc)
    end
  end
end
