class CreateAssembliesStockholders < ActiveRecord::Migration
  def change
    create_table :assemblies_stockholders, id: false do |t|
      t.references :assembly, index: true, null: false
      t.references :stockholder, index: true, null: false
    end
  end
end
