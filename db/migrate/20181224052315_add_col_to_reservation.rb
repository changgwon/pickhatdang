class AddColToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :restaurant_name, :string
  end
end
