# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, length: {maximum: 50}, index: {unique: true}
      t.string :owner, null: false, length: {maximum: 50}
      t.string :reroute_email, null: false, length: {maximum: 60}
      t.string :api_secret, null: false, length: {maximum: 128}, index: {unique: true}
      t.string :api_key, null: false, length: {maximum: 128}, index: {unique: true}
      t.boolean :is_active, null: false, default: false
      t.boolean :are_emails_sent, null: false, default: false
      t.timestamps
    end
  end
end
