require "rails_helper"

RSpec.describe SubmissionsController do
  describe "POST to :create" do
    let(:landing_application) { instance_double(LandingApplication, application_reference: double) }
    let(:processor) { instance_double(SubmissionsProcessor) }

    it "asks the submissions reference generator for a reference" do
      allow(SubmissionsProcessor).to receive(:new).and_return(processor)

      allow(processor).to receive(:call).and_return(landing_application)

      allow(ApplicationReferenceGenerator).to receive(:generate).and_return(double)

      post :create

      expect(ApplicationReferenceGenerator).to have_received(:generate)
    end

    it "passes the reference and session to submissions processor" do
      reference = double("reference")
      allow(ApplicationReferenceGenerator).to receive(:generate).and_return(reference)

      expect(SubmissionsProcessor).to receive(:new)
        .with(reference: reference, session: request.session)
        .and_return(processor)

      allow(processor).to receive(:call).and_return(landing_application)

      post :create

      expect(processor).to have_received(:call)
    end
  end
end
