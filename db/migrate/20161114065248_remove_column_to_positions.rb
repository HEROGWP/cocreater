class RemoveColumnToPositions < ActiveRecord::Migration[5.0]
  def change
  	remove_column :positions, :category, :string
  end
end
