class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :callbacks do |t|
      t.string :data, null: false
      t.string :status, null: false
      t.timestamps
    end

    create_table :messages do |t|
      t.references :client, null: false, foreign_key: true
      t.string :uuid, null: false, index: {unique: true}
      t.string :sender
      t.string :subject
      t.string :html_body
      t.string :text_body
      t.string :content_type
      t.string :priority
      t.string :environment
      t.datetime :scheduled_at
      t.timestamps
    end

    create_table :recipients do |t|
      t.references :message, null: false, foreign_key: true
      t.string :uuid, null: false, index: {unique: true}
      t.string :recipient_type
      t.string :email_address, null: false
      t.datetime :sent_at
      t.datetime :delivered_at
      t.datetime :opened_at
      t.datetime :clicked_at
      t.timestamps
    end

    create_table :blacklisted_emails do |t|
      t.string :address, null: false, index: {unique: true}
      t.string :reason, null: false
      t.timestamps
    end
  end
end
