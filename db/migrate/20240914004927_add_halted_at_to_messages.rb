class AddHaltedAtToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :halted_at, :datetime
  end
end
