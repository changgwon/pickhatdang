class ChangeColumnToRecommendationSystem < ActiveRecord::Migration[5.1]
  def change
    change_column :recommendation_systems, :location_division, :text, array: true
  end
end
