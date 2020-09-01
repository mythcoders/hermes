class AddRemainingFields < ActiveRecord::Migration[6.0]
  def change
    add_column :message_activities, :bounce_subtype, :string
    add_column :message_activities, :delay_type, :string
    add_column :message_activities, :expiration_time, :datetime
  end
end
