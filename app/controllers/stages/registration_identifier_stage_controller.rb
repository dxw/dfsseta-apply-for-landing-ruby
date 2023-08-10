# frozen_string_literal: true

class Stages::RegistrationIdentifierStageController < ApplicationController
  def show
    @registration_identifier = SpacecraftRegistrationIdentifierForm.new(registration_id: nil)
  end

  def update
    @registration_identifier = SpacecraftRegistrationIdentifierForm.new(
      registration_id: params[:spacecraft_registration_identifier_form][:registration_id]
    )

    if @registration_identifier.valid?
      answers.save(
        stage_name: :registration_identifier, answer: {
          registration_id: @registration_identifier.registration_id
        }
      )
      redirect_to(stages_personal_details_path)
    else
      render :show
    end
  end

  private

  def answers
    @answers ||= AnswersRepository.new(session)
  end
end
