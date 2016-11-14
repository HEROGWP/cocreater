class AddColumnToPositions < ActiveRecord::Migration[5.0]
  def change
  	add_column :positions, :category_id, :integer
  	add_index :positions, :category_id
  end
end
