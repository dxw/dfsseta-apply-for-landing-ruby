# frozen_string_literal: true

class Stages::DatesStageController < ApplicationController
  def show
    @dates = DatesForm.new(
      landing_date: saved_date("landing_date"),
      departure_date: saved_date("departure_date"),
      bank_holidays: BankHolidaysService.load
    )
  end

  def update
    @dates = DatesForm.new(
      landing_date: landing_date,
      departure_date: departure_date,
      bank_holidays: BankHolidaysService.load
    )
    if @dates.valid?
      answers.save(
        stage_name: :dates, answer: {
          landing_date: @dates.landing_date,
          departure_date: @dates.departure_date
        }
      )
      redirect_to(stages_registration_identifier_path)
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

  def saved_date(date_name)
    Date.parse(answers.find(:dates)&.dig(date_name))
  rescue TypeError, Date::Error
    nil
  end

  def answers
    @answers ||= AnswersRepository.new(session)
  end
end
