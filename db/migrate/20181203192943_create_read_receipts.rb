class CreateReadReceipts < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

    add_column :mail_logs, :tracking_id, :string, null: false, default: ""

    create_table :read_receipts do |t|
      t.belongs_to :mail_log, null: false
      t.string :remote_ip
      t.string :user_agent
      t.string :filename
      t.timestamps
    end

    create_table :read_receipts_queries do |t|
      t.belongs_to :read_receipt, null: false
      t.string :field
      t.string :value
      t.timestamps
    end
  end
end
