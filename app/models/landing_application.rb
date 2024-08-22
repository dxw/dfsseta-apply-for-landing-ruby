class LandingApplication < ApplicationRecord
  belongs_to :destination, foreign_key: :destination_id, class_name: "LandableBody"
end
