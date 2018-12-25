class RestaurantRecommendationController < ApplicationController
  before_action :authenticate_user!
  def my_page
    if current_user.recommendation_systems.first!=nil
    recommendation_system=current_user.recommendation_systems.first
    recommendation_system.location_division=[]
    recommendation_system.food_category=nil
    recommendation_system.save
    end
    Priority.create(current_user)
  end
  def get_recommendation
    if current_user.priorities.first == nil
      redirect_to '/restaurant_recommendation/priority_setting'
    else
      @recommendation_system=current_user.recommendation_systems.first
      @priority=current_user.priorities.first
      Recommended.set_recommended(current_user,@recommendation_system,@priority)
      @sorted_r=Recommended.sort_where(current_user.id)
      end
  end
  def add_to_shopping_bag
    if !ShoppingBag.exists?(:user_id=>current_user.id,:r_id=>params[:restaurant_id])
      ShoppingBag.create_shopping_bag(current_user.id,params[:restaurant_id])
    end
    redirect_to '/restaurant_recommendation/get_recommendation'
  end
  def get_shopping_bag
    @shopping_bag = ShoppingBag.read_shopping_bag(current_user.id)
  end
  def remove_from_shopping_bag
    ShoppingBag.delete_restaurant(current_user.id,params[:restaurant_id])
    redirect_to '/restaurant_recommendation/get_shopping_bag'
  end
  def priority_setting
    @priority=current_user.priorities.first
  end
  def create_priority
    Priority.create_priority(priority_params,current_user.id)
    recommendation_system= RecommendationSystem.new(priority_params)
    recommendation_system.user_id=current_user.id
    recommendation_system.save
    redirect_to '/'
  end
  def update_priority
    Priority.update_priority(priority_params,current_user)
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

end
