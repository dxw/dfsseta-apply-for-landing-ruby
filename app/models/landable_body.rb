class LandableBody < ApplicationRecord
  has_many :landing_applications, foreign_key: :destination_id

  scope :active, -> {
    where(active: true)
      .order(name: :asc)
  }
end
