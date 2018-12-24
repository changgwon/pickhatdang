class ChangeColToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :reservedate, :integer
  end
end
