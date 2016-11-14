class AddColumnToProjects < ActiveRecord::Migration[5.0]
  def change
  	add_column :projects, :vision, :text 
  	add_column :projects, :story, :text
  end
end
