class AddMissingIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :client_environments, %i[client_id name], unique: true
    add_index :mailing_topics, %i[client_id name], unique: true
    add_index :subscribers, %i[client_id address], unique: true
    add_index :subscriptions, %i[mailing_topic_id subscriber_id], unique: true
    add_index :subscriptions, :identifier, unique: true
    add_index :subscriptions, :status
    add_index :templates, %i[client_id name], unique: true
  end
end
