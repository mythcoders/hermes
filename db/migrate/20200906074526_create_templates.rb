class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.belongs_to :client, null: false, foreign_key: true, index: true
      t.string :name
      t.string :sender_name
      t.string :sender_address
      t.string :html_body
      t.string :text_body
      t.string :json_layout
      t.boolean :active
      t.timestamps
    end
  end
end
