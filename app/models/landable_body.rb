class LandableBody < ApplicationRecord
  scope :active, -> {
    where(active: true)
      .order(name: :asc)
  }
end
