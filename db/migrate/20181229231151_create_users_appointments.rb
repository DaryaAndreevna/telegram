class CreateUsersAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :users_appointments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :appointment, index: true, foreign_key: true
    end
  end
end
