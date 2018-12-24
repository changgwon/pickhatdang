class CreateRecommendeds < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendeds do |t|

      t.integer :r_id
      t.float :rating
      t.integer :waiting
      t.timestamps
    end
  end
end
