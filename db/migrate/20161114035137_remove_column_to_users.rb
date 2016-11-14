class RemoveColumnToUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :school, :string
  	remove_column :users, :fb_id, :string
  	remove_column :users, :line_id, :string
  end
end
