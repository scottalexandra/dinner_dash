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
    item.price / 100
  end

  def subtotal(price, quantity)
    price * quantity
  end
end
