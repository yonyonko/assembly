class RemoveEmailFromAssembly < ActiveRecord::Migration
  def change
    remove_column :assemblies, :email, :string
    add_column :assemblies, :description, :text
  end
end
