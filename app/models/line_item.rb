class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

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
