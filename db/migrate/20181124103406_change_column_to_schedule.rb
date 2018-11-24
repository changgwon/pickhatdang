class ChangeColumnToSchedule < ActiveRecord::Migration[5.1]
  def change
    change_column :schedules, :starttime, :datetime, :default => 0
    change_column :schedules, :endtime, :datetime, :default => 0
  end
end
