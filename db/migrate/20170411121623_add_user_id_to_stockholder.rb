class AddUserIdToStockholder < ActiveRecord::Migration
  def change
    add_column :stockholders, :user_id, :integer
  end
end
