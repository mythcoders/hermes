class AddEnvironmentToApi < ActiveRecord::Migration[5.2]
  def change
    add_column :mail_logs, :environment, :string, null: false
  end
end
