# frozen_string_literal: true

class Stages::CheckYourAnswersStageController < ApplicationController
  def show
    stages_questions_and_answers
  end

  private

  def stages_questions_and_answers
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
            answer: destination_answer
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
            answer: date_answer("landing_date")
          ),
          CheckYourAnswers::Question.new(
            ref: :departure_date,
            title: "Requested departure date",
            answer: date_answer("departure_date")
          )
        ]
      ),

      CheckYourAnswers::Stage.new(
        name: "registration_identifier",
        title: "Spacecraft Registration Identifier",
        link_path: stages_registration_identifier_path,
        link_text: "Registration ID",
        questions: [
          CheckYourAnswers::Question.new(
            ref: :registration_id,
            title: "Registration ID",
            answer: answers.find(:registration_identifier)&.dig("registration_id")
          )
        ]
      ),

      CheckYourAnswers::Stage.new(
        name: "personal_detals",
        title: "Personal details",
        link_path: stages_personal_details_path,
        link_text: "personal details",
        questions: [
          CheckYourAnswers::Question.new(
            ref: :fullname,
            title: "Name",
            answer: answers.find(:personal_details)&.dig("fullname")
          ),
          CheckYourAnswers::Question.new(
            ref: :email,
            title: "Email address",
            answer: answers.find(:personal_details)&.dig("email")
          ),
          CheckYourAnswers::Question.new(
            ref: :licence_id,
            title: "Licence ID",
            answer: answers.find(:personal_details)&.dig("licence_id")
          )
        ]
      )
    ]
  end

  def answers
    @answers ||= AnswersRepository.new(session)
  end

  def destination_answer
    LANDABLE_BODIES
      .find { |body| body.id == answers.find(:destination)&.dig("destination_id") }
      &.name
  end

  def date_answer(date_name)
    Date.parse(answers.find(:dates)&.dig(date_name))
      .strftime("%e %B %Y")
  rescue TypeError, Date::Error
    nil
  end
end
