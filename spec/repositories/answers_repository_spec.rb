require "rails_helper"

RSpec.describe AnswersRepository do
  describe "saving an answer for a given stage" do
    it "asks the session to update itself with the answer using the stage name as key" do
      dates_answer = {
        landing_date: double,
        departure_date: double
      }

      session = double("session", update: {})
      repository = AnswersRepository.new(session)

      repository.save(
        stage_name: :dates,
        answer: dates_answer
      )

      expect(session).to have_received(:update).with(dates: dates_answer)
    end
  end

  describe "finding an answer for a given stage" do
    it "asks the session to dig out the answer using the stage name as key" do
      session = double("session", dig: double)
      repository = AnswersRepository.new(session)

      repository.find(:dates)

      expect(session).to have_received(:dig).with(:dates)
    end
  end

  describe "#clear_session - to allow a fresh application for landing" do
    let(:session) do
      {
        "session_id" => "123",
        "_csrf_token" => "ABC",
        "dates" => {},
        "destination" => {"destination_id" => "ABC123"},
        "another_question" => "another answer"
      }
    end

    let(:repository) { AnswersRepository.new(session) }

    it "clears data from keys NOT named 'session_id' or '_csrf_token'" do
      allow(session).to receive(:delete)

      repository.clear_answers

      expect(session).to have_received(:delete).with("dates")
      expect(session).to have_received(:delete).with("destination")
      expect(session).to have_received(:delete).with("another_question")
    end

    it "leaves keys named 'session_id' or '_csrf_token'" do
      allow(session).to receive(:delete)

      repository.clear_answers

      expect(session).to_not have_received(:delete).with("session_id")
      expect(session).to_not have_received(:delete).with("_csrf_token")
    end
  end
end
