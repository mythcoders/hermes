class CreateClientUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :client_uploads do |t|
      t.belongs_to :client, null: false, foreign_key: true, index: true
      t.string :file_type
      t.string :status
      t.timestamps
    end
  end
end
