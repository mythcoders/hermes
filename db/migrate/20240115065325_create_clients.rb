class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :state, null: false
      t.string :key, null: false, index: true
      t.string :secret, null: false, index: true
      t.timestamps
    end

    create_table :environments do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name, null: false
      t.string :state, null: false
      t.boolean :regex, default: false, null: false
      t.string :reoute_address
      t.string :reply_to_address
      t.index [:client_id, :name], unique: true
      t.timestamps
    end
  end
end
