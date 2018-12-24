class ChangeRatingToRestaurant < ActiveRecord::Migration[5.1]
  def change
    change_column :restaurants, :rating, :float
  end
end
