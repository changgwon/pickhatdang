class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :schedules

  def self.read_table(restaurant_id)
    @tables =  Restaurant.find(restaurant_id).tables
    return @tables
  end
  def self.create_table(params,restaurant_id)
  @table = Table.new(params)
  @table.restaurant_id = restaurant_id
  @table.be_seated=false
  @table.save
  return @table
  end
  def self.update_table(params,table_id)
    @table =  Table.find(table_id)
    @table.update(params)
  end
  def self.seated(table_id)
    @table = Table.find(table_id)
    @table.be_seated = true
    @table.save
  end
  def self.out(table_id)
    @table = Table.find(table_id)
    @table.be_seated = false
    @table.save
  end




end

