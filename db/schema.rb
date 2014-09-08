ActiveRecord::Schema.define(version: 20140906000509) do

  enable_extension "plpgsql"

  create_table "hubs", force: true do |t|
    t.integer  "location_id",                                      null: false
    t.string   "type",                                             null: false
    t.string   "provider_id"
    t.decimal  "longitude",   precision: 10, scale: 6
    t.decimal  "latitude",    precision: 10, scale: 6
    t.string   "name"
    t.integer  "status_code",                          default: 1
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
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "remember_token"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
