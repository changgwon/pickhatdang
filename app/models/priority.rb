class Priority < ApplicationRecord
  belongs_to :user

  def self.create_or_get(user)
    if user.priorities.first.nil?
      @priority=Priority.new
    else
      @priority=user.priorities.first
    end
    return @priority
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
