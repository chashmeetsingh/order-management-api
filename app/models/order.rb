class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, allow_blank: false
  before_validation :has_products?, :on => [:create]

  validate :has_products?

  def has_products?
    if self.order_items.length <= 0
      errors.add(:order, "needs to have at least one product")
    end
  end

  def self.init(params)
    order = Order.new(
        email: params[:orders][:email]
    )
    order = self.add_products(order, params[:orders][:order_items])
    order
  end

  def self.add_products(order, items)
    for item in items
      order_item = OrderItem.new(
          inventory_id: item[:inventory_id],
          quantity: item[:quantity]
      )
      order.order_items << order_item
    end
    order
  end

  def update_attr(params)
    self.email = params[:orders][:email] if params[:orders][:email].present?

    self.update_products(params[:orders][:order_items]) if !params[:orders][:order_items].blank?

    has_products?
  end

  def update_products(inventory)
    order_items = []
    for item in inventory
      order_item = OrderItem.new(
          inventory_id: item[:inventory_id],
          quantity: item[:quantity],
          order_id: self.id
      )
      if order_item.inventory.status == "active"
        order_items << order_item
      else
        errors.add(:order_item, "does not exist")
      end
    end
    if order_items.size > 0
      self.order_items = order_items
    else
      errors.add(:order, "needs to have at least one product")
    end
  end

end
