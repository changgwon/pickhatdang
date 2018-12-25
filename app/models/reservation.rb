class Reservation < ApplicationRecord
  belongs_to :user

  def self.make_reservation(reservation_id,current_user_id, ncustomer, restaurant_id, reservedate, reservetime, table)
    submit=Reservation.new
    submit.schedule_id = reservation_id
    submit.user_id=current_user_id
    submit.ncustomer=ncustomer
    submit.table_id=table.first.id
    submit.restaurant_id=Restaurant.find(restaurant_id).id
    submit.reservedate=reservedate
    submit.reservetime=reservetime
    submit.restaurant_name=Restaurant.find(restaurant_id).name
    submit.save

  end

  def self.update_reservation(reservation_id, table_num, current_user_id, reservation_ncustomer, reservation_reservetime, reservation_reservedate)
    submit=Reservation.find(reservation_id)
    reservation=Schedule.find(submit.schedule_id)
    @table=Table.where("restaurant_id = ? AND table_num = ? ",reservation.restaurant_id,table_num )
    submit.user_id=current_user_id
    submit.ncustomer=reservation_ncustomer
    submit.table_id=@table.first.id
    submit.reservetime=reservation_reservetime
    submit.reservedate=reservation_reservedate
    submit.save

    return submit
  end

  def self.accept_reservation(reservation_id)
    reservation=Reservation.find(reservation_id)
    reservation.reservestatus=1
    reservation.save

    return reservation
  end

  def self.reject_reservation(reservation_id)
    reservation=Reservation.find(reservation_id)
    reservation.reservestatus=2
    reservation.save
  end
  def self.destroy_reservation(reservation_id)
    reservation=Reservation.find(reservation_id)
    schedule=Schedule.find(reservation.schedule_id)
    schedule.destroy
    reservation.destroy
  end
end
