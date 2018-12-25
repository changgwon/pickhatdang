class Priority < ApplicationRecord
  belongs_to :user

  def self.create(user)
    if user.priorities.first.nil?
      @priority=Priority.new
      @priority.user_id=user.id
      @priority.rating=1
      @priority.waiting=1
      @priority.price=1
      @priority.distance=1
      @priority.save
    end
  end
  def self.create_priority(priority_params,user_id)
    @priority=Priority.new(priority_params)
    @priority.user_id=user_id
    @priority.save
  end
  def self.update_priority(priority_params,user)
    @priority=user.priorities.first
    @priority.update(priority_params)
   end
end
