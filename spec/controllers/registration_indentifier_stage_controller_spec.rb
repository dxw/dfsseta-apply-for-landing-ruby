require "rails_helper"

RSpec.describe Stages::RegistrationIdentifierStageController do
  let(:repository) do
    instance_double(AnswersRepository).tap do |repository|
      allow(repository).to receive(:find)
      allow(repository).to receive(:save)
    end
  end

  before { allow(AnswersRepository).to receive(:new).and_return(repository) }

  describe "GET to :show" do
    it "asks the repository to find the user's answer to this stage" do
      get :show

      expect(repository).to have_received(:find).with(:registration_identifier)
    end
  end

  describe "PUT to :update" do
    it "asks the repository to save the user's answer to this stage" do
      put :update, params: {spacecraft_registration_identifier_form: {registration_id: "XXX111X"}}

      expect(repository).to have_received(:save).with(
        stage_name: :registration_identifier,
        answer: {registration_id: "XXX111X"}
      )
    end
  end
end
