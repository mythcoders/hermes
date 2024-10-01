class CreateBans < ActiveRecord::Migration[7.2]
  def change
    create_table :bans do |t|
      t.string :address, null: false, index: {unique: true}
      t.string :reason, null: false
      t.timestamps
    end
  end
end
