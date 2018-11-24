class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :genre
      t.integer :user_id
      t.integer :pricerange
      t.integer :opentime
      t.integer :closingtime
      t.integer :rating
      t.timestamps
    end
  end
end
