class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :table_id
      t.integer :ncustomer
      t.integer :starttime
      t.integer :endtime
      t.string :reservestatus
      t.integer :reservetime
      t.timestamps
    end
  end
end
