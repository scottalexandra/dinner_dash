require "rails_helper"

RSpec.describe Order, type: :model do
  let(:user) do
    User.create(first_name: "Alex",
                last_name: "Robinson",
                email: "alex@robinson.com",
                password: "password")
  end
  let(:order) { Order.new(user_id: user.id) }
  let!(:item) do
    @category = Category.create(name: "NewCategory")
    item = Item.new(title: "title",
                    description: "desc",
                    price: 2000,)
    item.categories << @category
    item.save
    item
  end

  it "is valid" do
    order.items << item
    expect(order).to be_valid
  end

  it "can have items" do
    order.items << item
    expect(order.items.first).to eq(item)
  end

  it "defaults to ordered" do
    order.items << item
    expect(order.status).to eq("ordered")
  end

  context "must have" do
    it "a user to be valid" do
      order.user_id = nil
      order.items << item
      expect(order.save).to eq false
    end
  end

  it "belongs to a user" do
    order.items << item
    order.save
    expect(order).to be_valid
    expect(user.orders.first).to eq(order)
  end

  it "can have formatted ordernumbers" do
    order = Order.create(user_id: 1)
    expect(order.format_order_number(order.id)).to eq("00001")
  end
end
