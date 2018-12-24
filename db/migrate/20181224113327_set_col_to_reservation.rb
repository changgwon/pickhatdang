class SetColToReservation < ActiveRecord::Migration[5.1]
  def change
    change_column :reservations, :reservestatus, :string, :default => 0
  end
end
