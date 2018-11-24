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

ActiveRecord::Schema.define(version: 20181124103406) do

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "genre"
    t.integer "user_id"
    t.integer "pricerange"
    t.integer "opentime"
    t.integer "closingtime"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "table_id"
    t.integer "restaurant_id"
    t.integer "ncustomer"
    t.datetime "starttime"
    t.datetime "endtime"
    t.string "reservestatus"
    t.integer "reservetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer "restaurant_id"
    t.boolean "be_seated"
    t.string "location"
    t.integer "nseats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "table_num"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "user_type"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
