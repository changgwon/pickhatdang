class CreatePriorities < ActiveRecord::Migration[5.1]
  def change
    create_table :priorities do |t|
      t.integer :user_id
      t.integer :distance
      t.integer :price
      t.integer :rating
      t.integer :waiting


      t.timestamps
    end
  end
end
