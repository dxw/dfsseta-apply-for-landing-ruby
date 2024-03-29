class DestinationForm
  include ActiveModel::Model

  attr_accessor :destination_id

  def initialize(destination_id:)
    @destination_id = destination_id
  end

  validates :destination_id, presence: {message: "Choose a destination"}
end
