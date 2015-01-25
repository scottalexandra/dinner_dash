class OrdersController < ApplicationController
  def new
    @items = []
    @cart.data.each do |item_id, quantity|
      item = Item.find(item_id.to_i)
      item.add_quantity(quantity)
      @items << item
    end
  end
end