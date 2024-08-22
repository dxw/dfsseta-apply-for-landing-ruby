class CreateLandingApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :landing_applications, id: :uuid do |t|
      t.uuid :destination_id, null: false
      t.string :pilot_email, null: false
      t.string :pilot_name, null: false
      t.string :pilot_licence_id, null: false
      t.string :spacecraft_registration_id, null: false
      t.date :landing_date, null: false
      t.date :departure_date, null: false
      t.string :application_reference, null: false
      t.datetime :application_submitted_at, null: false

      t.string :application_decision, null: true
      t.datetime :application_decision_made_at, null: true
      t.string :permit_id, null: true

      t.timestamps
    end

    add_index :landing_applications, :destination_id
    add_foreign_key :landing_applications, :landable_bodies, column: :destination_id
  end
end
