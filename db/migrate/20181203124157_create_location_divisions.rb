class CreateLocationDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table :location_divisions do |t|
      t.integer :category_id
      t.string :location
      t.timestamps
    end
  end
end
