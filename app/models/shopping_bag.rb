class ShoppingBag < ApplicationRecord
  belongs_to :user

  def self.create_shopping_bag(user_id, restaurant_id)
    @shopping_bag=ShoppingBag.new
    @shopping_bag.user_id=user_id
    @shopping_bag.r_id=restaurant_id
    @shopping_bag.save
  end

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
