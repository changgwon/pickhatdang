class RestaurantTableManagementController < ApplicationController

  before_action :authenticate_user!
  def home
    if current_user.user_type==1
      redirect_to '/restaurant_table_management/index_restaurant'
    else
      redirect_to '/restaurant_recommendation/my_page'
    end
  end

  def new_restaurant
    @restaurant = Restaurant.new
  end

  def update_restaurant
    Restaurant.update_restaurant(restaurant_params,params[:restaurant_id])
    redirect_to '/'
  end

  def index_restaurant
    @restaurants = Restaurant.read_restaurant(current_user.id)
    # @restaurants = current_user.restaurants
  end

  def delete_restaurant
    Restaurant.delete_restaurant(params[:restaurant_id])
    redirect_to '/'
  end

  def create_restaurant
    @restaurant = Restaurant.create_restaurant(restaurant_params,current_user.id)
    redirect_to '/'
  end

  def edit_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def index_table
    @tables = Table.read_table(params[:restaurant_id])
    @restaurant=Restaurant.find(params[:restaurant_id])
  end

  def new_table
    @table = Table.new
    @table.restaurant_id =params[:restaurant_id]
  end

  def create_table
    @table = Table.create_table(table_params,params[:restaurant_id])
    redirect_to "/restaurant_table_management/index_table/#{params[:restaurant_id]}"
  end

  def edit_table
    @table =  Table.find(params[:id])
  end

  def update_table
    Table.update_table(table_params,params[:table_id])
    redirect_to '/'
  end

  def index_schedule
    @schedules = Schedule.read_schedule(params[:restaurant_id],params[:table_id])
    @restaurant=Restaurant.find(params[:restaurant_id])
    @table=Table.find(params[:table_id])
  end

  def new_schedule
    @schedule = Schedule.new
    @schedule.restaurant_id=params[:restaurant_id]
    @schedule.table_id=params[:table_id]
  end

  def update_schedule
    Schedule.update(schedule_params,params[:id])
  end

  def create_schedule
    @schedule =  Schedule.create_schedule(schedule_params,params[:restaurant_id],params[:table_id])
    redirect_to "/restaurant_table_management/index_schedule/#{params[:restaurant_id]}/#{params[:table_id]}"
  end

  def edit_schedule
    @schedule = Schedule.find(params[:id])
  end

  def seated
    Table.seated(params[:table_id])
    redirect_back(fallback_location: root_path)
  end

  def out
    Table.out(params[:table_id])
    redirect_back(fallback_location: root_path)
  end

  def start
    Schedule.start(params[:schedule_id])
    redirect_back(fallback_location: root_path)
  end

  def end
    Schedule.end(params[:schedule_id])
    redirect_back(fallback_location: root_path)
  end


  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :genre,:pricerange,:opentime,:closingtime,:rating)
  end
  def table_params
    params.require(:table).permit(:be_seated, :location, :nseats, :table_num)
  end
  def schedule_params
    params.require(:schedule).permit(:ncustomer, :starttime, :endtime,:reservestatus,:reservetime,:isreserver, :user_id)
  end


end

