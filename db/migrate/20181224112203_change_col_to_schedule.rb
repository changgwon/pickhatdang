class ChangeColToSchedule < ActiveRecord::Migration[5.1]
  def change
    change_column :schedules, :reservestatus, :string, :default => 0
  end
end
