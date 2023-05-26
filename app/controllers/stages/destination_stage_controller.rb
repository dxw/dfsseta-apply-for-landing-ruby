# frozen_string_literal: true

class Stages::DestinationStageController < ApplicationController
  before_action :landable_bodies

  def show
    @destination = DestinationForm.new(destination_id: "")
  end

  def update
    @destination = DestinationForm.new(destination_id: params[:destination_form][:destination_id])
    if @destination.valid?
      redirect_to(stages_dates_path)
    else
      render :show
    end
  end

  def landable_bodies
    @landable_bodies = LANDABLE_BODIES
  end
end
