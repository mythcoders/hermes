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

ActiveRecord::Schema.define(version: 2018_12_03_192943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

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
    t.index ["api_key"], name: "index_clients_on_api_key", unique: true
    t.index ["api_secret"], name: "index_clients_on_api_secret", unique: true
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "mail_logs", force: :cascade do |t|
    t.string "from"
    t.string "to", null: false
    t.string "cc"
    t.string "bcc"
    t.string "subject", null: false
    t.string "body"
    t.string "content_type"
    t.boolean "was_rerouted", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "environment", null: false
    t.string "tracking_id", default: "", null: false
    t.index ["client_id"], name: "index_mail_logs_on_client_id"
  end

  create_table "read_receipts", force: :cascade do |t|
    t.bigint "mail_log_id", null: false
    t.string "remote_ip"
    t.string "user_agent"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mail_log_id"], name: "index_read_receipts_on_mail_log_id"
  end

  create_table "read_receipts_queries", force: :cascade do |t|
    t.bigint "read_receipt_id", null: false
    t.string "field"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_receipt_id"], name: "index_read_receipts_queries_on_read_receipt_id"
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

end
