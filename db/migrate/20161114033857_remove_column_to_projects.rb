class RemoveColumnToProjects < ActiveRecord::Migration[5.0]
  def change
  	remove_column :projects, :school, :string
  end
end
