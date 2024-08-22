class CreateLandableBodies < ActiveRecord::Migration[7.2]
  def change
    create_table :landable_bodies, id: :uuid do |t|
      t.text :name, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
