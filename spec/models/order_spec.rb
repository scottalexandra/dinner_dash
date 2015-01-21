require 'rails_helper'

RSpec.describe Order, :type => :model do
  it "can have items" do
    item1 = Item.create(title: "title", description: "description", price: 20000)
    order = Order.new
    order.items << item1

    expect(order.items.first).to eq(item1)
  end
end
