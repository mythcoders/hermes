class ImproveSubscriptions < ActiveRecord::Migration[6.0]
  def up
    change_column :subscriptions, :status, :integer, using: 'status::integer'
    add_column :subscriptions, :identifier, :string, null: false
  end

  def down
    change_column :subscriptions, :status, :string
    remove_column :subscriptions, :identifier
  end
end
