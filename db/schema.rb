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

ActiveRecord::Schema[7.1].define(version: 2024_04_06_161458) do
  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname", null: false
    t.string "sex", null: false
    t.date "DOB"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_people_on_user_id"
    t.check_constraint "sex IN ('unspecified', 'male', 'female', 'other')"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_type", default: 0, null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "organizations", "users"
  add_foreign_key "people", "users"
end
