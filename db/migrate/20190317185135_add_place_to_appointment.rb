class AddPlaceToAppointment < ActiveRecord::Migration[5.2]
  def change
    change_table :appointments do |t|
      t.references :place
    end
  end
end
