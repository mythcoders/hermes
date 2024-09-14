class AddOtherStatusDates < ActiveRecord::Migration[7.2]
  def change
    add_column :destinations, :bounced_at, :datetime
    add_column :destinations, :complained_at, :datetime
  end
end
