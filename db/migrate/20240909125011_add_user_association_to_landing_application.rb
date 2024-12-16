class AddUserAssociationToLandingApplication < ActiveRecord::Migration[7.2]
  def change
    add_reference :landing_applications, :assessor, foreign_key: {to_table: :users}, type: :uuid
  end
end
