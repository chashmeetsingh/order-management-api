class Inventory < ApplicationRecord
  enum status: [:active, :inactive]

  validates :name, :description, presence: true, allow_blank: false
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_items
end