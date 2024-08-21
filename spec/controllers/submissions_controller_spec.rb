require "rails_helper"

RSpec.describe SubmissionsController do
  describe "POST to :create" do
    it "asks the submissions reference generator for a reference" do
      processor = instance_double(SubmissionsProcessor)
      allow(SubmissionsProcessor).to receive(:new).and_return(processor)

      allow(processor).to receive(:call).and_return(double)

      allow(SubmissionsReferenceGenerator).to receive(:generate).and_return(double)

      post :create

      expect(SubmissionsReferenceGenerator).to have_received(:generate)
    end

    it "passes the reference and session to submissions processor" do
      reference = double("reference")
      allow(SubmissionsReferenceGenerator).to receive(:generate).and_return(reference)

      processor = instance_double(SubmissionsProcessor)
      expect(SubmissionsProcessor).to receive(:new)
        .with(reference: reference, session: request.session)
        .and_return(processor)

      allow(processor).to receive(:call).and_return(double)

      post :create

      expect(processor).to have_received(:call)
    end
  end
end
