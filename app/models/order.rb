class Order < ActiveRecord::Base
  validates :user_id, presence: true
  has_many :line_items
  has_many :items, through: :line_items

  belongs_to :user

  def create_line_items(cart_items)
    cart_items.map do |item_id, quantity|
      LineItem.create(item_id: item_id.to_i, quantity: quantity)
    end
  end

  def add_line_items_from_cart(cart)
    cart[:item_id]
  end

  def item_ids(order_items)
    item_ids = []
    order_items.each do |item|
      item_ids << item.id
    end
  end

  def find_order_items(order_id)
    @order = Order.find(id: order_id.to_i)
    @order.items
  end

  def total(line_items)
    line_items.map do |line_item|
      (line_item.quantity * line_item.item.price)/100
    end.reduce(:+)
  end
end
