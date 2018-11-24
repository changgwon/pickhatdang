class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.integer :table_id
      t.integer :restaurant_id
      t.integer :ncustomer
      t.integer :starttime
      t.integer :endtime
      t.string :reservestatus
      t.integer :reservetime
      t.timestamps
    end
  end
end
