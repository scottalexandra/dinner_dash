require "rails_helper"

RSpec.describe Cart, type: :model do
  it "has data" do
    cart = Cart.new("1" => 3)
    expect(cart.data).to eq("1" => 3)
  end

  it "is displays 0 when no data is given" do
    cart = Cart.new(nil)
    expect(cart.data).to eq({})
  end

  it "can have an item added" do
    cart = Cart.new(nil)
    cart.add_item("1")
    expect(cart.data).to eq("1" => 1)
  end

  it "can count items" do
    cart = Cart.new(nil)
    cart.add_item("1")
    cart.add_item("1")
    expect(cart.count(cart.data)).to eq(2)
  end

  it "can have an item removed" do
    cart = Cart.new(nil)
    cart.add_item("1")
    cart.remove_item("1")
    expect(cart.data).to eq("1" => 0)
  end
end
