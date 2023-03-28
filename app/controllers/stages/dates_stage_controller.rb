# frozen_string_literal: true

class Stages::DatesStageController < ApplicationController
  def show
    @dates = DatesForm.new(landing_date: landing_date, departure_date: departure_date)
  end

  def update
    @dates = DatesForm.new(
      landing_date: landing_date,
      departure_date: departure_date
    )
    if @dates.valid?
      redirect_to(stages_registration_number_path)
    else
      render :show
    end
  end

  private

  def landing_date
    Date.new(
      params.dig(:dates_form, "landing_date(1i)").to_i,
      params.dig(:dates_form, "landing_date(2i)").to_i,
      params.dig(:dates_form, "landing_date(3i)").to_i
    )
  rescue TypeError, Date::Error
    nil
  end

  def departure_date
    Date.new(
      params.dig(:dates_form, "departure_date(1i)").to_i,
      params.dig(:dates_form, "departure_date(2i)").to_i,
      params.dig(:dates_form, "departure_date(3i)").to_i
    )
  rescue TypeError, Date::Error
    nil
  end
end
