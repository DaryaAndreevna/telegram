class ChangeAttendeeLimitDefault < ActiveRecord::Migration[5.2]
  def change
  	change_column :appointments, :attendee_limit, :integer, default: nil
  end
end
