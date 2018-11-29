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

ActiveRecord::Schema.define(version: 2018_11_29_033057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "owner", null: false
    t.string "reroute_email", null: false
    t.string "api_secret", null: false
    t.string "api_key", null: false
    t.boolean "is_active", default: false, null: false
    t.boolean "is_allowed_to_send", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_applications_on_api_key", unique: true
    t.index ["api_secret"], name: "index_applications_on_api_secret", unique: true
    t.index ["name"], name: "index_applications_on_name", unique: true
  end

end
