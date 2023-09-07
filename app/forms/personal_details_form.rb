class PersonalDetailsForm
  include ActiveModel::Model

  attr_accessor :fullname, :email, :licence_id

  def initialize(fullname: nil, email: nil, licence_id: nil)
    @fullname = fullname
    @email = email
    @licence_id = licence_id
  end

  validates :fullname,
    presence: {
      message: "Enter your full name"
    }

  validates :email,
    presence: {
      message: "Enter your email address"
    },
    format: {
      with: /.+@.+\..+/,
      message: "Enter an email address in the correct format, like name@example.com"
    }

  validates :licence_id,
    presence: {
      message: "Enter your Licence ID"
    },
    length: {
      minimum: 8,
      message: "Your Licence ID must contain at least 8 characters"
    }
end
