class AddScheduleToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :schedule_id, :integer

  end
end
