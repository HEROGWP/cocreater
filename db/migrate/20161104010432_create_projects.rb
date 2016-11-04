class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
    	t.string :name
    	t.string :location
    	t.string :school
    	t.text :description
    	t.string :status, default: "募集中"
      t.timestamps
    end
  end
end
