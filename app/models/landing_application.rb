class LandingApplication < ApplicationRecord
  belongs_to :destination, foreign_key: :destination_id, class_name: "LandableBody"

  belongs_to :assessor, foreign_key: :assessor_id, class_name: "User", optional: true
end
