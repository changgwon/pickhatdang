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
  end
end
