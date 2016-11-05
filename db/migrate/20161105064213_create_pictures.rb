class CreatePictures < ActiveRecord::Migration[5.0]
  def change
  	create_table :pictures do |t|
  		t.integer :project_id
      t.timestamps
    end
    add_index :pictures, :project_id
  end

end
