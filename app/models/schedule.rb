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
    @schedule.starttime = Time.now
    @schedule.save
    table=@schedule.table
    Table.seated(table.id)
  end
  def self.end(schedule_id)
    @schedule=Schedule.find(schedule_id)
    @schedule.endtime = Time.now
    @schedule.save
    table=@schedule.table
    Table.out(table.id)
    # 총 식사테이블과 총 식사시간 저장
    puts @schedule.starttime
    mealtime=TimeDifference.between(@schedule.starttime,@schedule.endtime).in_minutes
    restuarant=Restaurant.where('id=?',table.restaurant_id).first
    restuarant.total_table=restuarant.total_table+1
    restuarant.total_time=restuarant.total_time+mealtime
    #### 대기시간 ####
    restuarant.waiting=restuarant.total_time/restuarant.total_table
    #### 대기시간 ####
    restuarant.save
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
