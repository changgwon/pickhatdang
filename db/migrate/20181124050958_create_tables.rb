class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :restaurant_id
      t.boolean :be_seated
      t.string :location
      t.integer :nseats

      t.timestamps
    end
  end
end
