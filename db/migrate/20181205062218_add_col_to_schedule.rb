class AddColToSchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :user_id, :integer
    add_column :schedules, :isreserver, :integer
  end
end
