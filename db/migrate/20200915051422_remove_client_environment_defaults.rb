class RemoveClientEnvironmentDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default :client_environments, :name, from: "f", to: nil
    change_column_default :client_environments, :status, from: "f", to: nil
  end
end
