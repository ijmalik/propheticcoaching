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

ActiveRecord::Schema.define(version: 20150618022629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishments", force: true do |t|
    t.text     "body"
    t.integer  "mentee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.text     "body"
    t.boolean  "last_import"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities_categories", id: false, force: true do |t|
    t.integer "activity_id"
    t.integer "category_id"
  end

  create_table "activity_categorizations", force: true do |t|
    t.integer  "activity_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: true do |t|
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefits", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "best_features", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chats", force: true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_id"
  end

  create_table "coaches_mentees_joins", force: true do |t|
    t.integer "coach_id"
    t.integer "mentee_id"
  end

  create_table "contact_requests", force: true do |t|
    t.string   "subject"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_no"
    t.string   "contact_mode"
    t.string   "city"
    t.string   "state_country"
    t.string   "website"
    t.string   "heard_mode"
    t.string   "purpose"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebook_categorizations", force: true do |t|
    t.integer  "ebook_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebooks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pdf"
    t.string   "sha"
  end

  create_table "email_histories", force: true do |t|
    t.text     "body"
    t.integer  "mentee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_series", force: true do |t|
    t.integer  "frequency",  default: 1
    t.string   "period",     default: "monthly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",                  default: false
    t.integer  "event_series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_id"
    t.string   "profile_type"
    t.integer  "coach_mentee_relation_id"
  end

  create_table "exercise_categorizations", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.text     "body"
    t.boolean  "last_import"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "featured_products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.decimal  "price"
    t.string   "profile_id"
    t.string   "profile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "goals", force: true do |t|
    t.integer  "mentee_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "google_events", force: true do |t|
    t.string   "url"
    t.integer  "profile_id"
    t.string   "profile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_calendar_api_key"
    t.string   "google_calendar_id"
  end

  create_table "mentees", force: true do |t|
    t.string   "donor_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "home_phone"
    t.string   "availability"
    t.text     "prophecy"
    t.string   "bc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coach_id"
    t.date     "date_of_birth"
  end

  create_table "pages", force: true do |t|
    t.integer  "ebook_id"
    t.string   "page_number"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_categorizations", force: true do |t|
    t.integer  "question_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "last_import", default: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "tasks", force: true do |t|
    t.text     "description"
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mentee_id"
  end

  create_table "time_slots", force: true do |t|
    t.integer  "time_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.string   "home_phone"
    t.string   "availablity_time"
    t.string   "best_time_to_call"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "status",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
