class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :name, :string
  	add_column :users, :phone, :string
  	add_column :users, :school, :string
  	add_column :users, :fb_id, :string
  	add_column :users, :line_id, :string
  	add_column :users, :description, :text
  end
end
