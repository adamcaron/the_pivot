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

ActiveRecord::Schema.define(version: 20150826003853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "image_url"
  end

  create_table "housing_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "location_id"
    t.float    "cost"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "gmaps"
    t.float    "lat"
    t.float    "long"
    t.integer  "host_id"
    t.integer  "number_of_guests"
    t.integer  "housing_type_id"
  end

  add_index "listings", ["housing_type_id"], name: "index_listings_on_housing_type_id", using: :btree
  add_index "listings", ["location_id"], name: "index_listings_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.text     "continent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_trips", force: :cascade do |t|
    t.integer "order_id"
    t.integer "trip_id"
    t.integer "quantity"
  end

  add_index "order_trips", ["order_id"], name: "index_order_trips_on_order_id", using: :btree
  add_index "order_trips", ["trip_id"], name: "index_order_trips_on_trip_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "guest_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.integer  "listing_id"
    t.string   "date_range"
  end

  add_index "reservations", ["guest_id"], name: "index_reservations_on_guest_id", using: :btree
  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.string   "occupation"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "host_id"
  end

  add_foreign_key "listings", "locations"
  add_foreign_key "order_trips", "listings", column: "trip_id"
  add_foreign_key "order_trips", "reservations", column: "order_id"
  add_foreign_key "reservations", "users", column: "guest_id"
end
