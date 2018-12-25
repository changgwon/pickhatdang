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
    @table=Table.where("restaurant_id = ? AND table_num = ? ",params[:restaurant_id],params[:table_num])
    reservation=Schedule.make_schedule(params[:restaurant_id], params[:table_num], params[:ncustomer], params[:reservedate], params[:reservetime])
    # reservation=Schedule.new
    # @table=Table.where("restaurant_id = ? AND table_num = ? ",params[:restaurant_id],params[:table_num])
    # reservation.ncustomer=params[:ncustomer]
    # reservation.table_id=@table.first.id
    # reservation.restaurant_id=Restaurant.find(params[:restaurant_id]).id
    # reservation.reservedate=params[:reservedate]
    # reservation.reservetime=params[:reservetime]
    # reservation.save
    Reservation.make_reservation(reservation.id,current_user.id, params[:ncustomer], params[:restaurant_id], params[:reservedate], params[:reservetime],  @table)
    # submit=Reservation.new
    # submit.schedule_id = reservation.id
    # submit.user_id=current_user.id
    # submit.ncustomer=params[:ncustomer]
    # submit.table_id=@table.first.id
    # submit.restaurant_id=Restaurant.find(params[:restaurant_id]).id
    # submit.reservedate=params[:reservedate]
    # submit.reservetime=params[:reservetime]
    # submit.restaurant_name=Restaurant.find(params[:restaurant_id]).name
    # submit.save

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

    schedule=Reservation.update_reservation(params[:reservation_id], params[:table_num], current_user.id, params[:reservation][:ncustomer], params[:reservation][:reservetime], params[:reservation][:reservedate])
    # submit=Reservation.find(params[:reservation_id])
    # reservation=Schedule.find(submit.schedule_id)
    # @table=Table.where("restaurant_id = ? AND table_num = ? ",reservation.restaurant_id,params[:table_num])
    # submit.user_id=current_user.id
    # submit.ncustomer=params[:reservation][:ncustomer]
    # submit.table_id=@table.first.id
    # submit.reservetime=params[:reservation][:reservetime]
    # submit.reservedate=params[:reservation][:reservedate]
    # submit.save
    @table=Table.where("restaurant_id = ? AND table_num = ? ",schedule.restaurant_id,params[:table_num])
    Schedule.change_schedule(schedule.id, params[:reservation][:ncustomer], params[:reservation][:reservetime], params[:reservation][:reservedate], @table)
    # reservation.ncustomer=params[:reservation][:ncustomer]
    # reservation.table_id=@table.first.id
    # reservation.reservetime=params[:reservation][:reservetime]
    # reservation.reservedate=params[:reservation][:reservedate]
    # reservation.save

    redirect_to "/restaurant_reservation/index_reservation"
  end

  def destroy_reservation
    Reservation.destroy_reservation(params[:reservation_id])
    # reservation=Reservation.find(params[:reservation_id])
    # schedule=Schedule.find(reservation.schedule_id)
    # reservation.destroy
    # schedule.destroy
    redirect_to '/restaurant_reservation/index_reservation'
  end

  def index_reserve_management
    @schedules=Schedule.where("restaurant_id = ? AND reservestatus = ?",params[:restaurant_id], 0)
    @reservations=Reservation.where("restaurant_id = ? AND reservestatus = ?", params[:restaurant_id], 0)
    @accepted_schedules=Schedule.where("restaurant_id = ? AND reservestatus =?", params[:restaurant_id], 1)

  end

  def accept_reservation
    reservation=Reservation.accept_reservation(params[:reservation_id])
    # reservation=Reservation.find(params[:reservation_id])
    # reservation.reservestatus=1
    # reservation.save

    Schedule.accept_reservation(reservation.schedule_id)
    # schedule=Schedule.find(reservation.schedule_id)
    # schedule.reservestatus=1
    # schedule.save

    redirect_to "/restaurant_reservation/index_reserve_management/#{reservation.restaurant_id}"
  end

  def reject_reservation
    reservation=Reservation.reject_reservation(params[:reservation_id])
    # reservation=Reservation.find(params[:reservation_id])
    # reservation.reservestatus=2
    # reservation.save

    Schedule.reject_reservation(reservation.schedule_id)
    # schedule=Schedule.find(reservation.schedule_id)
    # schedule.reservestatus=2
    # schedule.save

    redirect_to "/restaurant_reservation/index_reserve_management/#{reservation.restaurant_id}"
  end


  private
  # def schedule_params
  #   params.require(:schedule).permit(:ncustomer, :reservetime, :table_id)
  # end
end
