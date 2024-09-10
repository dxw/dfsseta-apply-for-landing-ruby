class User < ApplicationRecord
  devise :database_authenticatable, :recoverable

  has_many :assessed_applications, class_name: :LandingApplication, foreign_key: :assessor_id
end
