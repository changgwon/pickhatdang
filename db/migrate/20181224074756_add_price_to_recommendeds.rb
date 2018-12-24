class AddPriceToRecommendeds < ActiveRecord::Migration[5.1]
  def change
    add_column :recommendeds, :price, :float
  end
end
