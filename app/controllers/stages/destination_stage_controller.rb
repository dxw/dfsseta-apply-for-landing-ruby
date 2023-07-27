# frozen_string_literal: true

class Stages::DestinationStageController < ApplicationController
  before_action :landable_bodies

  def show
    @destination = DestinationForm.new(
      destination_id: answers.find(:destination)&.dig("destination_id")
    )
  end

  def update
    @destination = DestinationForm.new(
      destination_id: params[:destination_form][:destination_id]
    )

    if @destination.valid?
      answers.save(
        stage_name: :destination, answer: {destination_id: @destination.destination_id}
      )
      redirect_to(stages_dates_path)
    else
      render :show
    end
  end

  private

  def landable_bodies
    @landable_bodies = LANDABLE_BODIES
  end

  def answers
    @answers ||= AnswersRepository.new(session)
  end
end
