class ShoppingBag < ApplicationRecord
  belongs_to :user


  def self.read_shopping_bag(user_id)
    return ShoppingBag.where("user_id = ?",user_id)
  end

  def self.delete_restaurant(user_id, restaurant_id)
    @restaurant=ShoppingBag.where("user_id = ? AND r_id = ?",user_id, restaurant_id)
    puts @restaurant
    a=@restaurant.last
    a.delete
  end
end
