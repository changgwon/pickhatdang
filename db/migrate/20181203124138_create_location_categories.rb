class CreateLocationCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :location_categories do |t|
      t.string :location
      t.timestamps
    end
  end
end
