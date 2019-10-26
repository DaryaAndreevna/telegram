class AddUserCounterCacheToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :user_count, :integer, default: 0
  end
end
