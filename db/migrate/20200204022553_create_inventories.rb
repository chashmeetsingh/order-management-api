class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
