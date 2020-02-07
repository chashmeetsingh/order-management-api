class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :inventory_id
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
