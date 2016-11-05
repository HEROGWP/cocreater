class CreateUserCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_categoryships do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
    add_index :user_categoryships, :user_id
    add_index :user_categoryships, :category_id
  end
end
