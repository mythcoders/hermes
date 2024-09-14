class CreateWebhooks < ActiveRecord::Migration[7.2]
  def change
    create_table :webhooks do |t|
      t.string :state, null: false
      t.string :subject, null: false
      t.string :raw_data, null: false
      t.timestamps
    end
  end
end
