class CreateMessageActivity < ActiveRecord::Migration[5.2]
  def change
    drop_table :read_receipts_queries
    drop_table :read_receipts
    drop_table :mail_logs

    create_table :messages do |t|
      t.belongs_to :client, null: false
      t.string :sender
      t.string :subject, null: false
      t.string :body
      t.string :content_type
      t.string :priority
      t.string :environment
      t.string :tracking_id
      t.datetime :sent_at
      t.timestamps
    end

    create_table :message_recipients do |t|
      t.belongs_to :message, null: false
      t.string :email
      t.string :recipient_type
      t.datetime :send_at
      t.datetime :delivered_at
      t.timestamps
    end

    create_table :message_activities do |t|
      t.belongs_to :message, null: false
      t.string :activity_type
      t.string :activity_details
      t.string :ip_address
      t.string :user_agent
      t.string :link_url
      t.string :reject_reason
      t.string :reporting_mta
      t.string :smtp_response
      t.string :bounce_type
      t.string :feedback_id
      t.string :complaint_type
      t.datetime :complaint_arrival_date
      t.datetime :notification_timestamp
      t.timestamps
    end

    create_table :message_activity_recipients do |t|
      t.belongs_to :message_activity, null: false
      t.belongs_to :message_recipient, null: false
      t.string :action
      t.string :status
      t.string :diagnosticCode
      t.datetime :notification_timestamp
      t.timestamps
    end
  end
end
