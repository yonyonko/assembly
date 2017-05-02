class CreateStockholders < ActiveRecord::Migration
  def change
    create_table :stockholders do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
