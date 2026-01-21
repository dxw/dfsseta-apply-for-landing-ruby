require "rails_helper"

RSpec.describe Officer::DecisionsController do
  let(:officer) do
    FactoryBot.create(:user)
  end

  before { sign_in officer }

  describe "GET to :new" do
    context "when officer is signed in"
    it "calls AssessmentDecisionForm.new" do
      allow(AssessmentDecisionForm).to receive(:new)

      get :new, params: {landing_application_id: "abc123"}

      expect(AssessmentDecisionForm).to have_received(:new).with(application_decision: nil)
    end
  end

  describe "POST to :create" do
    context "when the decision is denied"
    it "updates the application and redirects to the landing applications index page" do
      form = instance_double(AssessmentDecisionForm, "valid?" => true, "application_decision" => "denied")
      allow(AssessmentDecisionForm).to receive(:new).and_return(form)

      landing_application = instance_double(LandingApplication, "valid?" => true, :save => double, "application_decision=" => "denied", "application_decision_made_at=" => Time.current, "assessor=" => officer)
      allow(LandingApplication).to receive(:find).and_return(landing_application)

      post :create, params: {landing_application_id: "abc123", assessment_decision_form: {application_decision: "denied"}}

      expect(landing_application).to have_received(:save)
      expect(response).to redirect_to(officer_landing_applications_path)
    end

    context "when the decision is approved"
    it "records a permit ID on the application" do
      allow(SecureRandom).to receive(:uuid).and_return("some-permit-id")

      form = instance_double(AssessmentDecisionForm, "valid?" => true, "application_decision" => "approved")
      allow(AssessmentDecisionForm).to receive(:new).and_return(form)
      landing_application = instance_double(LandingApplication, "valid?" => true, :save => double, "application_decision=" => "approved", "application_decision_made_at=" => Time.current, "assessor=" => officer)
      allow(LandingApplication).to receive(:find).and_return(landing_application)
      allow(landing_application).to receive(:permit_id=).and_return(nil)

      post :create, params: {landing_application_id: "abc123", assessment_decision_form: {application_decision: "approved"}}
      expect(landing_application).to have_received(:permit_id=).with("some-permit-id")
    end

    context "when no decision is submitted"
    it "doesn't save the application and renders :new" do
      form = instance_double(AssessmentDecisionForm, "valid?" => false, "application_decision" => nil)
      allow(AssessmentDecisionForm).to receive(:new).and_return(form)

      landing_application = instance_double(LandingApplication, "valid?" => false, :save => double, "application_decision=" => nil)
      allow(LandingApplication).to receive(:find).and_return(landing_application)

      post :create, params: {landing_application_id: "abc123", assessment_decision_form: {application_decision: nil}}

      expect(landing_application).not_to have_received(:save)
      expect(response).to render_template("new")
    end

    context "when a non-enum value is submitted"
    it "doesn't save the application and renders :new" do
      form = instance_double(AssessmentDecisionForm, "valid?" => false, "application_decision" => "proved")
      allow(AssessmentDecisionForm).to receive(:new).and_return(form)

      landing_application = instance_double(LandingApplication, :save => double, "application_decision=" => "proved")
      allow(LandingApplication).to receive(:find).and_return(landing_application)

      post :create, params: {landing_application_id: "abc123", assessment_decision_form: {application_decision: "proved"}}

      expect(landing_application).not_to have_received(:save)
      expect(response).to render_template("new")
    end
  end
end
