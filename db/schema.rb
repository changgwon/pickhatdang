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

ActiveRecord::Schema.define(version: 20181224113327) do

  create_table "basketlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_categories", force: :cascade do |t|
    t.string "food_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_categories", force: :cascade do |t|
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_divisions", force: :cascade do |t|
    t.integer "category_id"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_category_id"
  end

  create_table "priorities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "distance"
    t.integer "price"
    t.integer "rating"
    t.integer "waiting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendation_systems", force: :cascade do |t|
    t.integer "user_id"
    t.text "location_division"
    t.string "food_category"
    t.integer "distance"
    t.integer "price"
    t.integer "rating"
    t.integer "waiting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.integer "table_id"
    t.integer "ncustomer"
    t.integer "starttime"
    t.integer "endtime"
    t.string "reservestatus", default: "0"
    t.integer "reservetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "restaurant_name"
    t.integer "reservedate"
    t.integer "schedule_id"
  end

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
    t.string "reservestatus", default: "0"
    t.integer "reservetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "isreserver"
    t.integer "reservedate"
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
