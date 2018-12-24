class AddColumnToTable < ActiveRecord::Migration[5.1]
  def change
    add_column :tables, :table_num, :integer
  end
end
