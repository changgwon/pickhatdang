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
  def get_recommendation
    if current_user.priorities.first == nil
      redirect_to '/restaurant_recommendation/priority_setting'
    else
      @priority=current_user.priorities.first
      Restaurant.all.each do |r|
        if Recommended.exists?(:user_id=>current_user.id,:r_id=>r.id)
         @recommended=Recommended.where("user_id = ? AND r_id = ?" , current_user.id, r.id).last
        else
          @recommended=Recommended.new
          @recommended.user_id=current_user.id
          @recommended.r_id=r.id
        end
        @recommended.rating=Math.exp(-0.1*((r.rating-5)**2))*5
        @recommended.waiting=Math.exp(-0.001*(r.waiting**2.5))*5
        @recommended.price=Math.exp(-0.0007*((r.pricerange-4000)/200)**2)*5
        puts @recommended.rating
        @recommended.score=(@recommended.rating*@priority.rating+@recommended.price*@priority.price+@recommended.waiting*@priority.waiting)/(@priority.rating+@priority.waiting+@priority.price)
        @recommended.save
      end
      # Recommended.order('id ASC').reorder('score desc')
      @user_recommended=Recommended.where(user_id:current_user.id)
      @sorted_r=@user_recommended.sort_by { |e| -e[:score] }
      end
  end
  def add_to_shopping_bag
    if !ShoppingBag.exists?(:user_id=>current_user.id,:r_id=>params[:restaurant_id])
      @shopping_bag=ShoppingBag.new
      @shopping_bag.user_id=current_user.id
      @shopping_bag.r_id=params[:restaurant_id]
      @shopping_bag.save
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

end
