class CreateShoppingBags < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_bags do |t|
      t.integer :r_id
      t.timestamps
    end
  end
end
