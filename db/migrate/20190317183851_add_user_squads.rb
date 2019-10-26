class AddUserSquads < ActiveRecord::Migration[5.2]
  def change
    create_table :users_squads do |t|
      t.references :user, index: true, foreign_key: true
      t.references :squad, index: true, foreign_key: true
    end
  end
end
