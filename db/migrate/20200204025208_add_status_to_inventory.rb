class AddStatusToInventory < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :status, :integer, default: 0
  end
end
