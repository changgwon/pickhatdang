class CreateFoodCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :food_categories do |t|
      t.string :food_category
      t.timestamps
    end
  end
end
