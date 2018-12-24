class ChangeColumnToLocationDivision < ActiveRecord::Migration[5.1]
  def change
    add_column :location_divisions, :location_category_id, :integer
  end
end
