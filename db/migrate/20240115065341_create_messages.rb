class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :callbacks do |t|
      t.string :data, null: false
      t.string :status, null: false
      t.timestamps
    end

    create_table :messages do |t|
      t.references :client, null: false, foreign_key: true
      t.string :tracking_id
      t.string :sender
      t.string :subject, null: false
      t.string :html_body
      t.string :content_type
      t.string :priority
      t.string :environment
      t.string :text_body
      t.datetime :sent_at
      t.timestamps
    end

    create_table :recipients do |t|
      t.references :message, null: false, foreign_key: true
      t.string :recipient_type
      t.string :email_address, null: false
      t.datetime :send_at
      t.datetime :delivered_at
      t.timestamps
    end

    create_table :message_activities do |t|
      t.references :message, null: false, foreign_key: true, index: true
      t.references :recipient, null: true, foreign_key: true, index: true
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
      t.string :bounce_subtype
      t.string :delay_type
      t.datetime :expiration_time
      t.string :action
      t.string :status
      t.string :diagnostic_code
      t.timestamps
    end

    create_table :blacklisted_emails do |t|
      t.string :address, null: false
      t.string :reason, null: false
      t.timestamps
    end
  end
end
