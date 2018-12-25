class Recommended < ApplicationRecord
  belongs_to :user

  def self.read_recommended(user_id,r_id)
    return Recommended.where("user_id = ? AND r_id = ?" , user_id, r_id).last
  end

  def self.create_recommended(user_id,r_id)
    @recommended=Recommended.new
    @recommended.user_id=user_id
    @recommended.r_id=r_id
    @recommended.save
    return @recommended
  end

  def self.set_rwp(recommended,rating,waiting,price)
    recommended.rating=Math.exp(-0.1*((rating-5)**2))*5
    recommended.waiting=Math.exp(-0.001*(waiting**2.5))*5
    recommended.price=Math.exp(-0.0007*((price-4000)/200)**2)*5
    recommended.save
  end

  def self.calculate_score(priority,recommended)
    dividend=recommended.rating*priority.rating+recommended.price*priority.price+recommended.waiting*priority.waiting
    sum = priority.rating+priority.waiting+priority.price
    recommended.score=dividend/sum
    recommended.save
  end

  def self.sort_where(user_id)
    @user_recommended=Recommended.where(user_id:user_id)
    @sorted_r=@user_recommended.sort_by { |e| -e[:score] }
    return @sorted_r
  end


  def self.set_recommended(user,r_sys,p)
    r_sys.location_division.each do |l|
    Restaurant.where("location = ? AND genre = ?", l, r_sys.food_category).each do |r|
      if Recommended.exists?(:user_id=>user.id,:r_id=>r.id)
        @recommended=Recommended.read_recommended(user.id,r.id)
      else
        @recommended=Recommended.create_recommended(user.id,r.id)
      end
      Recommended.set_rwp(@recommended,r.rating,r.waiting,r.pricerange)
      Recommended.calculate_score(p,@recommended)
    end
    end
  end

end
