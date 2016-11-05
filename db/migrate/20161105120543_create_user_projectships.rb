class CreateUserProjectships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_projectships do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :join, default: false
      t.timestamps
    end
    add_index :user_projectships, :user_id
    add_index :user_projectships, :project_id
  end
end
