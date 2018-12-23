class CreateRecommendationSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendation_systems do |t|
      t.integer :user_id
      t.string :location_division
      t.string :food_category
      t.integer :distance
      t.integer :price
      t.integer :rating
      t.integer :waiting

      t.timestamps
    end
  end
end
