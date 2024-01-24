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

ActiveRecord::Schema[7.1].define(version: 2024_01_15_065341) do
  create_table "blacklisted_emails", force: :cascade do |t|
    t.string "address", null: false
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "callbacks", force: :cascade do |t|
    t.string "data", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state", default: 0, null: false
    t.string "username", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_clients_on_name", unique: true
    t.index ["password"], name: "index_clients_on_password"
    t.index ["username"], name: "index_clients_on_username"
  end

  create_table "environments", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", null: false
    t.integer "status", null: false
    t.boolean "regex", default: false, null: false
    t.string "reoute_address"
    t.string "reply_to_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "name"], name: "index_environments_on_client_id_and_name", unique: true
    t.index ["client_id"], name: "index_environments_on_client_id"
  end

  create_table "message_activities", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "recipient_id"
    t.string "activity_type"
    t.string "activity_details"
    t.string "ip_address"
    t.string "user_agent"
    t.string "link_url"
    t.string "reject_reason"
    t.string "reporting_mta"
    t.string "smtp_response"
    t.string "bounce_type"
    t.string "feedback_id"
    t.string "complaint_type"
    t.datetime "complaint_arrival_date"
    t.datetime "notification_timestamp"
    t.string "bounce_subtype"
    t.string "delay_type"
    t.datetime "expiration_time"
    t.string "action"
    t.string "status"
    t.string "diagnostic_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_activities_on_message_id"
    t.index ["recipient_id"], name: "index_message_activities_on_recipient_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "tracking_id"
    t.string "sender"
    t.string "subject", null: false
    t.string "html_body"
    t.string "content_type"
    t.string "priority"
    t.string "environment"
    t.string "text_body"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_messages_on_client_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.integer "message_id", null: false
    t.string "recipient_type"
    t.string "email_address", null: false
    t.datetime "send_at"
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_recipients_on_message_id"
  end

  add_foreign_key "environments", "clients"
  add_foreign_key "message_activities", "messages"
  add_foreign_key "message_activities", "recipients"
  add_foreign_key "messages", "clients"
  add_foreign_key "recipients", "messages"
end
