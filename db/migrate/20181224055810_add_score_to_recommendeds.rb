class AddScoreToRecommendeds < ActiveRecord::Migration[5.1]
  def change
    add_column :recommendeds, :score, :float
  end
end
