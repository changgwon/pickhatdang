class UpdateColToSchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :reservedate, :integer
  end
end
