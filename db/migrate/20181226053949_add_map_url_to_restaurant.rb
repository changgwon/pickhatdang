class AddMapUrlToRestaurant < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :map_url, :string
  end
end
