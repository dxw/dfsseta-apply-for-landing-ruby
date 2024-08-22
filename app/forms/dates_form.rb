class DatesForm
  include ActiveModel::Model

  attr_accessor :landing_date, :departure_date
  MAXIMUM_PERMITTED_STAY_IN_DAYS = 14
  BANK_HOLIDAYS = JSON.parse(File.read("#{Rails.root}/config/bank_holidays_uk.json")).dig('england-and-wales', 'events').map{ | event | event.fetch('date')}

  def initialize(landing_date:, departure_date:)
    @landing_date = landing_date
    @departure_date = departure_date
  end

  validates :landing_date, presence: {message: "Enter a landing date"}
  validates :departure_date, presence: {message: "Enter a departure date"}

  validates_comparison_of :landing_date, greater_than: Date.today, message: "Landing date must be in the future"
  validates_comparison_of :departure_date, greater_than: Date.today, message: "Departure date must be in the future"

  validate :ensure_departure_not_before_landing
  validate :ensure_departure_date_within_maximum_permitted_stay
  validate :ensure_dates_do_not_fall_on_bank_holidays

  def ensure_departure_not_before_landing
    return unless landing_date && departure_date

    if landing_date > departure_date
      errors.add(:base, "Landing date must be earlier than departure date")
    end
  end

  def ensure_departure_date_within_maximum_permitted_stay
    return unless landing_date && departure_date

    if (departure_date - landing_date) > MAXIMUM_PERMITTED_STAY_IN_DAYS
      errors.add(:departure_date, "Departure date must be within 14 days of landing date")
    end
  end

  def ensure_dates_do_not_fall_on_bank_holidays
    return unless landing_date && departure_date

    if BANK_HOLIDAYS.include?(landing_date.to_s)
      errors.add(:landing_date, "Landing date must not fall on a bank holiday")
    end

    if BANK_HOLIDAYS.include?(departure_date.to_s)
      errors.add(:departure_date, "Departure date must not fall on a bank holiday")
    end
  end
end
