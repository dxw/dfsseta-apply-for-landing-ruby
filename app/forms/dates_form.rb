class DatesForm
  include ActiveModel::Model

  attr_accessor :landing_date, :departure_date

  def initialize(landing_date:, departure_date:)
    @landing_date = landing_date
    @departure_date = departure_date
  end

  validates :landing_date, presence: {message: "Enter a landing date"}
  validates :departure_date, presence: {message: "Enter a departure date"}

  validates_comparison_of :landing_date, greater_than: Date.today, message: "Landing date must be in the future"
  validates_comparison_of :departure_date, greater_than: Date.today, message: "Departure date must be in the future"

  validate :ensure_departure_not_before_landing

  def ensure_departure_not_before_landing
    return unless landing_date && departure_date

    if landing_date > departure_date
      errors.add(:base, "Landing date must be earlier than departure date")
    end
  end
end
