class CreateMailingTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :mailing_topics do |t|
      t.belongs_to :client, null: false, foreign_key: true, index: true
      t.string :name
      t.string :description
      t.boolean :active
      t.timestamps
    end

    create_table :subscribers do |t|
      t.belongs_to :client, null: false, foreign_key: true, index: true
      t.string :name
      t.string :address
      t.timestamps
    end

    create_table :subscriptions do |t|
      t.belongs_to :mailing_topic, null: false, foreign_key: true, index: true
      t.belongs_to :subscriber, null: false, foreign_key: true, index: true
      t.string :status
      t.string :memo
      t.timestamps
    end
  end
end
