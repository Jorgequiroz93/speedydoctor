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

ActiveRecord::Schema.define(version: 2022_06_10_041453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultations", force: :cascade do |t|
    t.string "symptoms"
    t.string "status"
    t.float "total_price"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "room_url"
    t.index ["doctor_id"], name: "index_consultations_on_doctor_id"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.text "content"
    t.text "prescription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["consultation_id"], name: "index_reports_on_consultation_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.float "rating"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "speed_rating"
    t.float "gentleness_rating"
    t.float "professionalism_rating"
    t.float "clarity_rating"
    t.index ["consultation_id"], name: "index_reviews_on_consultation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "country"
    t.string "language"
    t.string "role"
    t.float "rate"
    t.string "specialty"
    t.string "sub_specialty"
    t.string "skills"
    t.string "prefix"
    t.string "status", default: "Off"
    t.string "diplomas"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "users", column: "doctor_id"
  add_foreign_key "consultations", "users", column: "patient_id"
  add_foreign_key "reports", "consultations"
  add_foreign_key "reviews", "consultations"
end
