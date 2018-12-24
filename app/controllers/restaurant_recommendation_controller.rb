class RestaurantRecommendationController < ApplicationController
  before_action :authenticate_user!
  def my_page
    if current_user.recommendation_systems.first!=nil
    recommendation_system=current_user.recommendation_systems.first
    recommendation_system.location_division=[]
    recommendation_system.food_category=nil
    recommendation_system.save
      end
  end
  def priority_setting
    if current_user.priorities.first.nil?
      @priority=Priority.new
    else
      @priority=current_user.priorities.first
    end
  end
  def create_priority
    @priority=Priority.new(priority_params)
    @priority.user_id=current_user.id
    @priority.save
    recommendation_system= RecommendationSystem.new(priority_params)
    recommendation_system.user_id=current_user.id
    recommendation_system.save


    redirect_to '/'
  end
  def update_priority
    @priority=current_user.priorities.first
    @priority.update(priority_params)
    recommendation_system=current_user.recommendation_systems.first
    recommendation_system.update(priority_params)
    redirect_to '/'
  end
  def search_setting

  end
  def search_location_category
    @locations=LocationCategory.all

  end
  def search_location_division
    @locations=LocationDivision.where("location_category_id = ?",params[:category_id])
  end
  def select_location_division
    recommendation_system=current_user.recommendation_systems.first
    recommendation_system.location_division = params[:location][:locations]
    recommendation_system.save
    redirect_to '/restaurant_recommendation/search_setting'
  end
  def search_food_category
    @foods=FoodCategory.all
  end
  def select_food_category
    recommendation_system=current_user.recommendation_systems.first
    recommendation_system.food_category = params[:food_category]
    recommendation_system.save
    redirect_to '/restaurant_recommendation/search_setting'
  end

  def search_restaurant
    @locations=params[:location][:locations]
    recommendation_system=current_user.recommendation_systems.first
    # recommendation_system.location_division = @locations
  end

  private
  def priority_params
    params.require(:priority).permit(:distance, :price, :rating,:waiting)
  end

  def flex;
  end

end
