class AddWaitingToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :waiting, :integer
  end
end
