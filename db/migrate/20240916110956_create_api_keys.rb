class CreateApiKeys < ActiveRecord::Migration[7.2]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.string :api_client_name, null: false
      t.string :token_digest, null: false

      t.timestamps
    end
    add_index :api_keys, :token_digest, unique: true
  end
end
