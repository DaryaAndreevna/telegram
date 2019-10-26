class AddSquads < ActiveRecord::Migration[5.2]
  def change
    create_table :squads do |t|
      t.boolean :active, default: true
      t.string :name
    end
  end
end
