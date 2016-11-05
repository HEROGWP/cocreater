class CreateProjectCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :project_categoryships do |t|
      t.integer :project_id
      t.integer :category_id

      t.timestamps
    end
    add_index :project_categoryships, :project_id
    add_index :project_categoryships, :category_id
  end
end
