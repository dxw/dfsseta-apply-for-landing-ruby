# frozen_string_literal: true

class Stages::CheckYourAnswersStageController < ApplicationController
  def show
    @stages_questions_and_answers = [
      CheckYourAnswers::Stage.new(
        name: "destination",
        title: "Destination",
        link_path: stages_destination_path,
        link_text: "destination",
        questions: [
          CheckYourAnswers::Question.new(
            ref: :destination,
            title: "Destination",
            answer: "Saturn (core)"
          )
        ]
      ),
      CheckYourAnswers::Stage.new(
        name: "dates",
        title: "Dates",
        link_path: stages_dates_path,
        link_text: "dates",
        questions: [
          CheckYourAnswers::Question.new(
            ref: :landing_date,
            title: "Requested landing date",
            answer: "10 August 2024"
          ),
          CheckYourAnswers::Question.new(
            ref: :departure_date,
            title: "Requested departure date",
            answer: "18 August 2024"
          )
        ]
      )
    ]
  end
end
