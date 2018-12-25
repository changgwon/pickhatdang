class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :tables
  mount_uploader :img_url, AvatarUploader

  def self.read_restaurant(user_id)
   return Restaurant.where("user_id = ?",user_id)
  end

  def self.create_restaurant(params,user_id)
    @restaurant = Restaurant.new(params)
    @restaurant.user_id = user_id
    #### 대기시간 ####
    @restaurant.total_table = 0
    @restaurant.total_time = 0
    @restaurant.waiting = 0
    #### 대기시간 ####
    @restaurant.save
    return @restaurant
  end


  def self.update_restaurant(params,restaurant_id)
    @restaurant = Restaurant.find(restaurant_id)
    @restaurant.update(params)
  end

  def self.delete_restaurant(restaurant_id)
    @restaurant=Restaurant.find(restaurant_id)
    @restaurant.delete
  end
end
