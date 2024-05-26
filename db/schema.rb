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

ActiveRecord::Schema[7.1].define(version: 2024_05_19_150413) do
  create_table "avatars", force: :cascade do |t|
    t.string "image"
    t.string "imageable_type", null: false
    t.integer "imageable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_avatars_on_imageable"
  end

  create_table "cvs", force: :cascade do |t|
    t.integer "person_id", null: false
    t.text "about", null: false
    t.text "skills"
    t.string "country"
    t.string "city"
    t.text "interests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_cvs_on_person_id"
  end

  create_table "educations", force: :cascade do |t|
    t.integer "cv_id", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "institution", null: false
    t.string "direction", null: false
    t.string "specialization", null: false
    t.string "education_level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_educations_on_cv_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "address", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address", "user_id"], name: "index_emails_on_address_and_user_id", unique: true
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.integer "cv_id", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "position", null: false
    t.string "country"
    t.string "city"
    t.string "company"
    t.text "outline", null: false
    t.text "responsibilities"
    t.text "achievements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_experiences_on_cv_id"
  end

  create_table "languages", force: :cascade do |t|
    t.integer "cv_id", null: false
    t.string "name", null: false
    t.string "level", null: false
    t.string "certificates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_languages_on_cv_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "address", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["address", "user_id"], name: "index_links_on_address_and_user_id", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "message", null: false
    t.string "link"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

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

  create_table "telephones", force: :cascade do |t|
    t.string "number", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "number"], name: "index_telephones_on_user_id_and_number", unique: true
    t.index ["user_id"], name: "index_telephones_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_type", default: 0, null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "salary_min_cents"
    t.integer "salary_max_cents"
    t.string "currency", null: false
    t.string "country"
    t.string "city"
    t.text "skills_mandatory"
    t.text "skills_optional"
    t.integer "experience"
    t.string "job_type", null: false
    t.string "education", null: false
    t.string "subordination_level", null: false
    t.string "contract_type", null: false
    t.string "working_time", null: false
    t.string "work_type", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id", null: false
    t.index ["organization_id"], name: "index_vacancies_on_organization_id"
  end

  create_table "vacancy_responses", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "vacancy_id", null: false
    t.string "status", null: false
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "vacancy_id"], name: "index_vacancy_responses_on_person_id_and_vacancy_id", unique: true
    t.index ["person_id"], name: "index_vacancy_responses_on_person_id"
    t.index ["vacancy_id"], name: "index_vacancy_responses_on_vacancy_id"
    t.check_constraint "status IN ('sent', 'under consideration', 'in reserve', 'interview scheduled', 'internship offered', 'accepted', 'rejected')"
  end

  add_foreign_key "cvs", "people"
  add_foreign_key "educations", "cvs"
  add_foreign_key "emails", "users"
  add_foreign_key "experiences", "cvs"
  add_foreign_key "languages", "cvs"
  add_foreign_key "links", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "people", "users"
  add_foreign_key "telephones", "users"
  add_foreign_key "vacancies", "organizations"
  add_foreign_key "vacancy_responses", "people"
  add_foreign_key "vacancy_responses", "vacancies"
end
