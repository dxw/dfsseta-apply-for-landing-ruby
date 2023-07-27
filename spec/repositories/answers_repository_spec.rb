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
end
