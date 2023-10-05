class SpacecraftRegistrationIdentifierForm
  include ActiveModel::Model

  attr_accessor :registration_id

  def initialize(registration_id:)
    @registration_id = registration_id
  end

  validates :registration_id,
    presence: {
      message: "Enter a Spacecraft Registration Identifier"
    },
    format: {
      with: /[A-Z]{3}\d{3}[A-Z]/,
      message: "Enter a Spacecraft Registration Identifier in the form ABC123A (3 letters - 3 digits - 1 letter)"
    }
end
