class CreateMailLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_logs do |t|
      t.string :from
      t.string :to, null: false
      t.string :cc
      t.string :bcc
      t.string :subject, null: false
      t.string :body
      t.string :type
      t.boolean :was_rerouted, null: false
      t.belongs_to :client, null: false
      t.timestamps
    end
  end
end
