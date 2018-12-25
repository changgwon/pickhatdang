class AddImgUrlToRestaurant < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :img_url, :string
  end
end
