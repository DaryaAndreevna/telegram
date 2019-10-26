class AddPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, default: ''
      t.string :address, default: ''
      t.float :lat
      t.float :lon
    end
  end
end
