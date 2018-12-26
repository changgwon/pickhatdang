class AddDataToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :total_table, :integer
    add_column :restaurants, :total_time, :float
  end
end
