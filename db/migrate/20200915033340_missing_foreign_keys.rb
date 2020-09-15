class MissingForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :messages, :clients
    add_foreign_key :message_recipients, :messages
    add_foreign_key :client_environments, :clients
    add_foreign_key :message_activities, :messages
    add_foreign_key :message_activity_recipients, :message_activities
    add_foreign_key :message_activity_recipients, :message_recipients
  end
end
