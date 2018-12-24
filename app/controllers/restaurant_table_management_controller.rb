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
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.update(restaurant_params)
    redirect_to '/'
  end
  def index_restaurant
    @restaurants = current_user.restaurants

  end
  def delete_restaurant
    @restaurant=Restaurant.find(params[:restaurant_id])
    @restaurant.delete
    redirect_to '/'
  end
  def index_table
    @restaurant = Restaurant.find(params[:restaurant_id])
    @tables =  Restaurant.find(params[:restaurant_id]).tables
  end
  def create_restaurant
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    @restaurant.save
    redirect_to '/'
  end
  def edit_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def new_table
    @table = Table.new
    @table.restaurant_id =params[:restaurant_id]

  end
  def update_table
    @table =  Table.find(params[:table_id])
    @table.update(table_params)
  end
  def index_schedule
    @table = Table.find(params[:table_id])
    @restaurant =  Restaurant.find(params[:restaurant_id])
    @schedules = Schedule.where("restaurant_id = ? AND table_id = ?", params[:restaurant_id],params[:table_id])
  end
  def create_table
    @table =  Table.new(table_params)
    @table.restaurant_id = params[:restaurant_id]
    @table.be_seated=false
    @table.save
    redirect_to "/restaurant_table_management/index_table/#{params[:restaurant_id]}"
  end
  def edit_table
    @table =  Table.find(params[:id])
  end
  def new_schedule
    @schedule = Schedule.new
    @schedule.restaurant_id=params[:restaurant_id]
    @schedule.table_id=params[:table_id]

  end
  def update_schedule
    @schedule = Schedule.find(params[:id])
    @schedule.update(schedule_params)
  end

  def create_schedule
    @schedule = Schedule.new(schedule_params)
    @schedule.table_id = params[:table_id]
    @schedule.restaurant_id = params[:restaurant_id]
    @schedule.save
    redirect_to "/restaurant_table_management/index_schedule/#{params[:restaurant_id]}/#{params[:table_id]}"

  end
  def edit_schedule
    @schedule = Schedule.find(params[:id])
  end

  def seated
    @table = Table.find(params[:table_id])
    @table.be_seated = true
    @table.save
    redirect_back(fallback_location: root_path)

  end
  def out
    @table = Table.find(params[:table_id])
    @table.be_seated = false
    @table.save
    redirect_back(fallback_location: root_path)
  end

  def start
    @schedule=Schedule.find(params[:schedule_id])
    @schedule.starttime=Time.now.strftime("%H:%M:%S")
    @schedule.save
    redirect_back(fallback_location: root_path)
  end
  def end
    @schedule=Schedule.find(params[:schedule_id])
    @schedule.endtime=Time.now.strftime("%H:%M:%S")
    @schedule.save
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
