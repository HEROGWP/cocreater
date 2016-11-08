class AddColumnDeadlineAndCategoryToProject < ActiveRecord::Migration[5.0]
  def change
  	add_column :projects, :category, :string
  	add_column :projects, :startdate, :date
  	add_column :projects, :deadline, :date
  end
end
