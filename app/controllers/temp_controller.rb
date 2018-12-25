class TempController < ApplicationController

  ###########################################
  ####TEST DATA를 만들기 위한 CONTROLLER#####
  ###########################################

  def new_location
    @location=LocationCategory.new
  end

  def create_location
    @location=LocationCategory.new
    @location.location=params[:location_category][:location]
    @location.save
  end

  def new_division
    @division=LocationDivision.new
  end
  def create_division
    @division=LocationDivision.new
    @division.location=params[:location_division][:location]
    @division.location_category_id=10
    @division.save
  end
  def new_food
    @food=FoodCategory.new
  end
  def create_food
    @food=FoodCategory.new
    @food.food_category=params[:food_category][:food_category]
    @food.save
  end

end
