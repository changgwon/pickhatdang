class Schedule < ApplicationRecord
  belongs_to :table

  def self.index_schedule
    @schedules = Schedule.read_schedule(params[:restaurant_id],params[:table_id])
  end
  def self.read_schedule(restaurant_id,table_id)
    @schedules = Schedule.where("restaurant_id = ? AND table_id = ?", restaurant_id,table_id)
    return @schedules
  end

  def self.update_schedule(params,schedule_id)
    @schedule = Schedule.find(schedule_id)
    @schedule.update(params)
  end

  def self.create_schedule(params,restaurant_id,table_id)
    @schedule = Schedule.new(params)
    @schedule.table_id = table_id
    @schedule.restaurant_id = restaurant_id
    @schedule.save
   return @schedule

  end

  def self.start(schedule_id)
  @schedule=Schedule.find(schedule_id)
  @schedule.starttime=Time.now.strftime("%H:%M:%S")
  @schedule.save
  end
  def self.end(schedule_id)
  @schedule=Schedule.find(schedule_id)
  @schedule.endtime=Time.now.strftime("%H:%M:%S")
  @schedule.save
  end

  def self.make_schedule(restaurant_id, table_num, ncustomer, reservedate, reservetime)
    reservation=Schedule.new
    @table=Table.where("restaurant_id = ? AND table_num = ? ",restaurant_id,table_num)
    reservation.ncustomer=ncustomer
    reservation.table_id=@table.first.id
    reservation.restaurant_id=Restaurant.find(restaurant_id).id
    reservation.reservedate=reservedate
    reservation.reservetime=reservetime
    reservation.save

    return reservation
  end

  def self.change_schedule(schedule_id, reservation_ncustomer, reservation_reservetime, reservation_reservedate, table)
    reservation=Schedule.find(schedule_id)
    reservation.ncustomer=reservation_ncustomer
    reservation.table_id=table.first.id
    reservation.reservetime=reservation_reservetime
    reservation.reservedate=reservation_reservedate
    reservation.save
  end

  def self.accept_reservation(reservation_schedule_id)
    schedule=Schedule.find(reservation_schedule_id)
    schedule.reservestatus=1
    schedule.save
  end

  def self.reject_reservation(reservation_schedule_id)
    schedule=Schedule.find(reservation_schedule_id)
    schedule.reservestatus=2
    schedule.save
  end

end
