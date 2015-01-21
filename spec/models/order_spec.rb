require 'rails_helper'

RSpec.describe Order, :type => :model do
  it "can have items" do
    item1 = Item.create(title: "title",
                        description: "description",
                        price: 20000)
    order = Order.new(user_id: 1)
    order.items << item1
    expect(order.items.first).to eq(item1)
  end

  it "defaults to ordered" do
    item1 = Item.create(title: "title",
                        description: "description",
                        price: 20000)
    order = Order.new(user_id: 1)
    order.items << item1
    expect(order.status).to eq("ordered")
  end

  context "must have" do
    it "items to be valid" do
      user = User.create(first_name: "Alex",
                         last_name: "Robinson",
                         email: "alex@robinson.com")
      order = Order.new(user_id: user.id)
      expect(order).to_not be_valid
    end

    it "a user to be valid" do
      item1 = Item.create(title: "title",
                          description: "description",
                          price: 20000)
      order = Order.new()
      order.items << item1
      expect(order).to_not be_valid
    end
  end
end
