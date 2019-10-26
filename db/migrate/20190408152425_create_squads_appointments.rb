class CreateSquadsAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :squads_appointments do |t|
      t.references :squad, index: true, foreign_key: true
      t.references :appointment, index: true, foreign_key: true
    end
  end
end
