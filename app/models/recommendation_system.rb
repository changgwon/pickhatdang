class RecommendationSystem < ApplicationRecord
  belongs_to :user
  serialize :location_division, Array
end
