class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item, unscoped: true

  def title
    item.title
  end

  def description
    item.description
  end

  def price
    item.currency
  end

  def subtotal(price, quantity)
    price * quantity
  end
end
