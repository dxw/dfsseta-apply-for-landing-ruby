# frozen_string_literal: true

class Stages::PersonalDetailsStageController < ApplicationController
  def show
    @personal_details = PersonalDetailsForm.new(
      fullname: answers.find(:personal_details)&.dig("fullname"),
      email: answers.find(:personal_details)&.dig("email"),
      licence_id: answers.find(:personal_details)&.dig("licence_id")
    )
  end

  def update
    @personal_details = PersonalDetailsForm.new(
      fullname: params[:personal_details_form][:fullname],
      email: params[:personal_details_form][:email],
      licence_id: params[:personal_details_form][:licence_id]
    )

    if @personal_details.valid?
      answers.save(
        stage_name: :personal_details, answer: {
          fullname: @personal_details.fullname,
          email: @personal_details.email,
          licence_id: @personal_details.licence_id
        }
      )
      redirect_to(stages_check_your_answers_path)
    else
      render :show
    end
  end

  private

  def answers
    @answers ||= AnswersRepository.new(session)
  end
end
