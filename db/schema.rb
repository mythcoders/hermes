# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_15_051422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "callbacks", force: :cascade do |t|
    t.string "data", default: "f", null: false
    t.string "status", default: "f", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "client_environments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name", null: false
    t.string "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_client_environments_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "owner", null: false
    t.string "reroute_email", null: false
    t.string "api_secret", null: false
    t.string "api_key", null: false
    t.boolean "is_active", default: false, null: false
    t.boolean "are_emails_sent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reply_to_email"
    t.index ["api_key"], name: "index_clients_on_api_key", unique: true
    t.index ["api_secret"], name: "index_clients_on_api_secret", unique: true
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "mailing_topics", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name"
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_mailing_topics_on_client_id"
  end

  create_table "message_activities", force: :cascade do |t|
    t.bigint "message_id", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bounce_subtype"
    t.string "delay_type"
    t.datetime "expiration_time"
    t.index ["message_id"], name: "index_message_activities_on_message_id"
  end

  create_table "message_activity_recipients", force: :cascade do |t|
    t.bigint "message_activity_id", null: false
    t.bigint "message_recipient_id", null: false
    t.string "action"
    t.string "status"
    t.string "diagnosticCode"
    t.datetime "notification_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_activity_id"], name: "index_message_activity_recipients_on_message_activity_id"
    t.index ["message_recipient_id"], name: "index_message_activity_recipients_on_message_recipient_id"
  end

  create_table "message_recipients", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.string "email"
    t.string "recipient_type"
    t.datetime "send_at"
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_recipients_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "sender"
    t.string "subject", null: false
    t.string "html_body"
    t.string "content_type"
    t.string "priority"
    t.string "environment"
    t.string "tracking_id"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text_body"
    t.index ["client_id"], name: "index_messages_on_client_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_subscribers_on_client_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "mailing_topic_id", null: false
    t.bigint "subscriber_id", null: false
    t.string "status"
    t.string "memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mailing_topic_id"], name: "index_subscriptions_on_mailing_topic_id"
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "name"
    t.string "sender_name"
    t.string "sender_address"
    t.string "html_body"
    t.string "text_body"
    t.string "json_layout"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_templates_on_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "client_environments", "clients"
  add_foreign_key "mailing_topics", "clients"
  add_foreign_key "message_activities", "messages"
  add_foreign_key "message_activity_recipients", "message_activities"
  add_foreign_key "message_activity_recipients", "message_recipients"
  add_foreign_key "message_recipients", "messages"
  add_foreign_key "messages", "clients"
  add_foreign_key "subscribers", "clients"
  add_foreign_key "subscriptions", "mailing_topics"
  add_foreign_key "subscriptions", "subscribers"
  add_foreign_key "templates", "clients"
end
