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
