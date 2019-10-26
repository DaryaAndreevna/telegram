class AddWeeklyRecordsLimitToSquads < ActiveRecord::Migration[5.2]
  def change
  	add_column :squads, :weekly_records_limit, :integer, default: 2
  end
end
