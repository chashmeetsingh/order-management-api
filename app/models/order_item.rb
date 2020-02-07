class OrderItem < ApplicationRecord
  belongs_to :inventory
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  before_create :product_available?
  before_update :product_available?
  after_save :update_inventory
  after_destroy :return_stocks

  def product_available?
    if self.inventory || self.inventory.quantity < self.quantity || self.inventory.status == :inactive
      errors.add(:inventory, "item less in quantity")
      false
    end
    true
  end

  def update_inventory
    inventory = Inventory.find(self.inventory_id)
    inventory.update!(
        quantity: inventory.quantity - self.quantity
    )
  end

  def return_stocks
    self.inventory.update!(
        quantity: self.inventory.quantity + self.quantity
    )
  end
end