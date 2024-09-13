class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: true
      t.string :uuid, null: false, index: {unique: true}
      t.string :from
      t.string :subject
      t.string :html_body
      t.string :text_body
      t.string :content_type
      t.string :priority
      t.string :raw_profile
      t.datetime :scheduled_at
      t.timestamps
    end

    create_table :destinations do |t|
      t.references :message, null: false, foreign_key: true
      t.string :uuid, null: false, index: {unique: true}
      t.string :address_type, null: false
      t.string :address, null: false
      t.datetime :sent_at
      t.datetime :delivered_at
      t.datetime :opened_at
      t.datetime :clicked_at
      t.timestamps
    end
  end
end
