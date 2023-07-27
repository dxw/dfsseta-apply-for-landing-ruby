require "rails_helper"

RSpec.describe Stages::DestinationStageController do
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

      expect(repository).to have_received(:find).with(:destination)
    end
  end

  describe "PUT to :update" do
    it "asks the repository to save the user's answer to this stage" do
      put :update, params: {destination_form: {destination_id: "abc123"}}

      expect(repository).to have_received(:save).with(
        stage_name: :destination,
        answer: {destination_id: "abc123"}
      )
    end
  end
end
