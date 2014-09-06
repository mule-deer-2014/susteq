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

ActiveRecord::Schema.define(version: 20140906000509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hubs", force: true do |t|
    t.integer  "location_id",                          null: false
    t.string   "type",                                 null: false
    t.string   "provider_id"
    t.decimal  "longitude",   precision: 10, scale: 6
    t.decimal  "latitude",    precision: 10, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.string   "country",     null: false
    t.string   "duns_number", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.datetime "transaction_time",                           null: false
    t.integer  "location_id",                                null: false
    t.decimal  "longitude",         precision: 10, scale: 6
    t.decimal  "latitude",          precision: 10, scale: 6
    t.integer  "rfid_id"
    t.integer  "starting_credits"
    t.integer  "ending_credits"
    t.integer  "transaction_code",                           null: false
    t.integer  "amount"
    t.string   "error_code"
    t.integer  "transactable_id"
    t.string   "transactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type"
    t.integer  "provider_id"
    t.string   "name",           null: false
    t.string   "email",          null: false
    t.string   "password_hash",  null: false
    t.string   "remember_token"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
