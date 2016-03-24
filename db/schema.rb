# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160323151908) do

  create_table "_volunteers_old_20150310", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
    t.boolean  "physical_activity"
    t.string   "shirt_size"
    t.text     "comments"
    t.integer  "number_of_shirts"
    t.boolean  "golfer"
    t.boolean  "waiver"
    t.integer  "person_id"
    t.string   "session"
    t.string   "wednesday"
    t.string   "thursday"
    t.string   "friday"
    t.string   "saturday"
    t.string   "sunday"
  end

  create_table "caddies", force: true do |t|
    t.integer  "golfer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
    t.string   "golf"
    t.string   "course"
    t.string   "rules"
    t.integer  "person_id"
    t.boolean  "experience_as_caddie"
    t.integer  "age"
    t.boolean  "waiver"
  end

  add_index "caddies", ["person_id"], name: "index_caddies_on_person_id"

  create_table "committees", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committees_volunteers", force: true do |t|
    t.integer "volunteer_id"
    t.integer "committee_id"
  end

  create_table "golfers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "caddie_preferences"
    t.integer  "person_id"
    t.string   "arrival_day"
    t.string   "country"
    t.string   "school"
  end

  add_index "golfers", ["person_id"], name: "index_golfers_on_person_id"

  create_table "golfers_housings", id: false, force: true do |t|
    t.integer "housing_id"
    t.integer "golfer_id"
  end

  add_index "golfers_housings", ["golfer_id"], name: "index_golfers_housings_on_golfer_id"
  add_index "golfers_housings", ["housing_id", "golfer_id"], name: "index_golfers_housings_on_housing_id_and_golfer_id"

  create_table "housings", force: true do |t|
    t.date     "available"
    t.integer  "number_of_bedrooms"
    t.string   "number_of_bathrooms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pets"
    t.boolean  "smoking"
    t.text     "comments"
    t.integer  "person_id"
    t.integer  "max_guests"
    t.boolean  "specific_golfers"
    t.boolean  "is_active"
  end

  add_index "housings", ["person_id"], name: "index_housings_on_person_id"

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs_volunteers", force: true do |t|
    t.integer "volunteer_id"
    t.integer "job_id"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.integer "zip"
    t.string  "phone"
    t.integer "organization_id"
    t.boolean "is_active"
  end

  add_index "people", ["organization_id"], name: "index_people_on_organization_id"

  create_table "shifts", force: true do |t|
    t.string   "time"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts_volunteers", force: true do |t|
    t.integer "volunteer_id"
    t.integer "shift_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "volunteers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
    t.boolean  "physical_activity"
    t.string   "shirt_size"
    t.text     "comments"
    t.integer  "number_of_shirts"
    t.boolean  "golfer"
    t.boolean  "waiver"
    t.integer  "person_id"
    t.string   "wednesday"
    t.string   "thursday"
    t.string   "friday"
    t.string   "saturday"
    t.string   "sunday"
    t.integer  "uniform_price"
    t.datetime "thursday_time"
    t.integer  "thursday_hole"
    t.datetime "friday_time"
    t.integer  "friday_hole"
    t.datetime "saturday_time"
    t.integer  "saturday_hole"
    t.datetime "sunday_time"
    t.integer  "sunday_hole"
  end

  add_index "volunteers", ["person_id"], name: "index_volunteers_on_person_id"

  create_table "work_days", force: true do |t|
    t.datetime "time"
    t.integer  "job_id"
    t.integer  "volunteer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
