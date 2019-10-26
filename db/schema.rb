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

ActiveRecord::Schema.define(version: 2019_05_27_110917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "time"
    t.integer "attendee_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_count", default: 0
    t.bigint "place_id"
    t.index ["place_id"], name: "index_appointments_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", default: ""
    t.string "address", default: ""
    t.float "lat"
    t.float "lon"
  end

  create_table "squads", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "name"
    t.integer "weekly_records_limit", default: 2
  end

  create_table "squads_appointments", force: :cascade do |t|
    t.bigint "squad_id"
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_squads_appointments_on_appointment_id"
    t.index ["squad_id"], name: "index_squads_appointments_on_squad_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "telegram_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0
    t.string "chat_id"
  end

  create_table "users_appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_users_appointments_on_appointment_id"
    t.index ["user_id"], name: "index_users_appointments_on_user_id"
  end

  create_table "users_squads", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "squad_id"
    t.index ["squad_id"], name: "index_users_squads_on_squad_id"
    t.index ["user_id"], name: "index_users_squads_on_user_id"
  end

  add_foreign_key "squads_appointments", "appointments"
  add_foreign_key "squads_appointments", "squads"
  add_foreign_key "users_appointments", "appointments"
  add_foreign_key "users_appointments", "users"
  add_foreign_key "users_squads", "squads"
  add_foreign_key "users_squads", "users"
end
