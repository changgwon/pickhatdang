class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :schedules
end
