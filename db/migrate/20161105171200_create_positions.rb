class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
    	t.string :name
    	t.text :description
    	t.integer :user_id, default: 1
    	t.integer :project_id
      t.timestamps
    end
    add_index :positions, :user_id
    add_index :positions, :project_id
  end
end
