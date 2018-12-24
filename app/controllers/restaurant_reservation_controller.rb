class RestaurantReservationController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def home
    if current_user.user_type==1
      redirect_to '/restaurant_table_management/index_restaurant'
    else
      redirect_to '/restaurant_recommendation/my_page'
    end

  end

  def index_basket
    @restaurants=Restaurant.all
  end

  def restaurantInfo
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def new_schedule
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create_schedule
    reservation=Schedule.new
    @table=Table.where("restaurant_id = ? AND table_num = ? ",params[:restaurant_id],params[:table_num])
    reservation.ncustomer=params[:ncustomer]
    reservation.table_id=@table.first.id
    reservation.restaurant_id=Restaurant.find(params[:restaurant_id]).id
    reservation.reservedate=params[:reservedate]
    reservation.reservetime=params[:reservedate]
    reservation.save

    submit=Reservation.new
    submit.schedule_id = reservation.id
    submit.user_id=current_user.id
    submit.ncustomer=params[:ncustomer]
    submit.table_id=@table.first.id
    submit.reservedate=params[:reservedate]
    submit.reservetime=params[:reservetime]
    submit.restaurant_name=Restaurant.find(params[:restaurant_id]).name
    submit.save

    redirect_to "/restaurant_reservation/index_reservation"
  end

  def index_reservation
    @reservations=Reservation.all
  end

  def edit_reservation

    @reservation=Reservation.find(params[:reservation_id])
    # @table=Table.where("restaurant_id = ? AND table_num = ? ",params[:restaurant_id],params[:table_num])
  end

  def update_reservation

    submit=Reservation.find(params[:reservation_id])
    reservation=Schedule.find(submit.schedule_id)
    @table=Table.where("restaurant_id = ? AND table_num = ? ",reservation.restaurant_id,params[:table_num])


    puts "*"*100
    puts params[:ncustomer]
    puts "*"*100
    submit.user_id=current_user.id
    submit.ncustomer=params[:reservation][:ncustomer]
    submit.table_id=@table.first.id
    submit.reservetime=params[:reservation][:reservetime]
    submit.reservedate=params[:reservation][:reservedate]
    submit.save

    reservation.ncustomer=params[:reservation][:ncustomer]
    reservation.table_id=@table.first.id
    reservation.reservetime=params[:reservation][:reservetime]
    reservation.reservedate=params[:reservation][:reservedate]
    reservation.save

    redirect_to "/restaurant_reservation/index_reservation"
  end

  def destroy_reservation
    reservation=Reservation.find(params[:reservation_id])
    reservation.destroy
    schedule=Schedule.find(params[:reservation_id])
    schedule.destroy
    redirect_to '/restaurant_reservation/index_reservation'
  end

  private
  # def schedule_params
  #   params.require(:schedule).permit(:ncustomer, :reservetime, :table_id)
  # end
end
