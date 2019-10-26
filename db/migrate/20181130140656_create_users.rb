class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :telegram_id
      t.integer :role
      t.timestamps
    end
  end
end
