class ChangeColumnUserIdToPositions < ActiveRecord::Migration[5.0]
  def change
  	change_column :positions, :user_id, :integer, default: nil
  end
end
