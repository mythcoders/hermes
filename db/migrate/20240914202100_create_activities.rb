class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.references :recipient, null: false, foreign_key: true
      t.string :actionable_type
      t.integer :actionable_id
      t.datetime :actioned_at
      t.index [:actionable_type, :actionable_id]
      t.timestamps
    end

    create_table :bounces do |t|
      t.string :category
      t.string :sub_category
      t.string :feedback_id
      t.string :reporting_mta
      t.string :status
      t.string :action
      t.string :diagnostic_code
      t.timestamps
    end

    create_table :deliveries do |t|
      t.string :smtp_response
      t.string :reporting_mta
      t.timestamps
    end

    create_table :opens do |t|
      t.string :ip_address
      t.string :user_agent
      t.timestamps
    end

    create_table :clicks do |t|
      t.string :url
      t.string :ip_address
      t.string :user_agent
      t.timestamps
    end

    create_table :complaints do |t|
      t.string :category
      t.string :feedback_id
      t.string :user_agent
      t.datetime :arrived_at
      t.timestamps
    end

    create_table :rejections do |t|
      t.string :reason
      t.timestamps
    end

    create_table :delays do |t|
      t.string :category
      t.string :status
      t.string :diagnotic_code
      t.datetime :expires_at
      t.timestamps
    end
  end
end
