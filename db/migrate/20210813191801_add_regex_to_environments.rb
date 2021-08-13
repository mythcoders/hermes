class AddRegexToEnvironments < ActiveRecord::Migration[6.0]
  def change
    add_column :client_environments, :regex, :boolean, default: false, null: false
  end
end
