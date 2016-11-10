class AddColumnCategoryToPosition < ActiveRecord::Migration[5.0]
  def change
  	add_column :positions, :category, :string
  	add_index :positions, :category
  end
end
