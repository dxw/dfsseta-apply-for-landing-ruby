require "rails_helper"

RSpec.describe SubmissionsController do
  describe "POST to :create" do
    it "asks the submissions reference generator for a reference" do
      allow(SubmissionsReferenceGenerator).to receive(:generate).and_return(double)

      post :create

      expect(SubmissionsReferenceGenerator).to have_received(:generate)
    end
  end
end
