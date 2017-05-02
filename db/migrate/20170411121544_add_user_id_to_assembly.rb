class AddUserIdToAssembly < ActiveRecord::Migration
  def change
    add_column :assemblies, :user_id, :integer
  end
end
