class User < ApplicationRecord
  devise :database_authenticatable, :recoverable

  has_many :landing_applications, foreign_key: :assessor_id
end
