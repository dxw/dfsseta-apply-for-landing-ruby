# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_16_110956) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "api_client_name", null: false
    t.string "token_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_digest"], name: "index_api_keys_on_token_digest", unique: true
  end

  create_table "landable_bodies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "landing_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "destination_id", null: false
    t.string "pilot_email", null: false
    t.string "pilot_name", null: false
    t.string "pilot_licence_id", null: false
    t.string "spacecraft_registration_id", null: false
    t.date "landing_date", null: false
    t.date "departure_date", null: false
    t.string "application_reference", null: false
    t.datetime "application_submitted_at", null: false
    t.datetime "application_decision_made_at"
    t.string "permit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "assessor_id"
    t.integer "application_decision"
    t.index ["assessor_id"], name: "index_landing_applications_on_assessor_id"
    t.index ["destination_id"], name: "index_landing_applications_on_destination_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "landing_applications", "landable_bodies", column: "destination_id"
  add_foreign_key "landing_applications", "users", column: "assessor_id"
end
