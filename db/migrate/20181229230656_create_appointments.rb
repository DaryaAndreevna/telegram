class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :time
      t.integer :attendee_limit, default: 0
      t.timestamps
    end
  end
end
