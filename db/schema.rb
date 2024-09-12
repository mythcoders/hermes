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

ActiveRecord::Schema[7.2].define(version: 2024_09_12_030545) do
  create_table "bans", force: :cascade do |t|
    t.string "address", null: false
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_bans_on_address", unique: true
  end

  create_table "destinations", force: :cascade do |t|
    t.integer "message_id", null: false
    t.string "uuid", null: false
    t.string "address_type", null: false
    t.string "address", null: false
    t.datetime "sent_at"
    t.datetime "delivered_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_destinations_on_message_id"
    t.index ["uuid"], name: "index_destinations_on_uuid", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "profile_id", null: false
    t.string "uuid", null: false
    t.string "from"
    t.string "subject"
    t.string "html_body"
    t.string "text_body"
    t.string "content_type"
    t.string "priority"
    t.datetime "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_messages_on_profile_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
    t.index ["uuid"], name: "index_messages_on_uuid", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.string "name", null: false
    t.string "state", null: false
    t.boolean "regex", default: false, null: false
    t.string "reoute_address"
    t.string "reply_to_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id", "name"], name: "index_profiles_on_sender_id_and_name", unique: true
    t.index ["sender_id"], name: "index_profiles_on_sender_id"
  end

  create_table "senders", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.string "key", null: false
    t.string "secret", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_senders_on_key"
    t.index ["name"], name: "index_senders_on_name", unique: true
    t.index ["secret"], name: "index_senders_on_secret"
  end

  add_foreign_key "destinations", "messages"
  add_foreign_key "messages", "profiles"
  add_foreign_key "messages", "senders"
  add_foreign_key "profiles", "senders"
end
