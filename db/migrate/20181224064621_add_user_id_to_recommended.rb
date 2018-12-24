class AddUserIdToRecommended < ActiveRecord::Migration[5.1]
  def change
    add_column :recommendeds, :user_id, :integer
  end
end
