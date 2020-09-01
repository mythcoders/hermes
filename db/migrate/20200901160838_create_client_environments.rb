class CreateClientEnvironments < ActiveRecord::Migration[6.0]
  def change
    create_table :callbacks do |t|
      t.string :data, null: false, default: false
      t.string :status, null: false, default: false
      t.timestamps
    end

    create_table :client_environments do |t|
      t.belongs_to :client, null: false
      t.string :name, null: false, default: false
      t.string :status, null: false, default: false
      t.timestamps
    end

    add_column :clients, :reply_to_email, :string
    rename_column :messages, :body, :html_body
    add_column :messages, :text_body, :string
  end
end
