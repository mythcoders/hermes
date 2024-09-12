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

ActiveRecord::Schema[7.2].define(version: 2024_01_15_065341) do
  create_table "blacklisted_emails", force: :cascade do |t|
    t.string "address", null: false
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_blacklisted_emails_on_address", unique: true
  end

  create_table "callbacks", force: :cascade do |t|
    t.string "data", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.string "key", null: false
    t.string "secret", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_clients_on_key"
    t.index ["name"], name: "index_clients_on_name", unique: true
    t.index ["secret"], name: "index_clients_on_secret"
  end

  create_table "environments", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", null: false
    t.string "state", null: false
    t.boolean "regex", default: false, null: false
    t.string "reoute_address"
    t.string "reply_to_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "name"], name: "index_environments_on_client_id_and_name", unique: true
    t.index ["client_id"], name: "index_environments_on_client_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "uuid", null: false
    t.string "sender"
    t.string "subject"
    t.string "html_body"
    t.string "text_body"
    t.string "content_type"
    t.string "priority"
    t.string "environment"
    t.datetime "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_messages_on_client_id"
    t.index ["uuid"], name: "index_messages_on_uuid", unique: true
  end

  create_table "recipients", force: :cascade do |t|
    t.integer "message_id", null: false
    t.string "uuid", null: false
    t.string "recipient_type"
    t.string "email_address", null: false
    t.datetime "sent_at"
    t.datetime "delivered_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_recipients_on_message_id"
    t.index ["uuid"], name: "index_recipients_on_uuid", unique: true
  end

  add_foreign_key "environments", "clients"
  add_foreign_key "messages", "clients"
  add_foreign_key "recipients", "messages"
end
