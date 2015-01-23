require "rails_helper"

RSpec.describe Cart, type: :model do
  it "has data" do
    cart = Cart.new({"1" => 3})
    expect(cart.data).to eq({"1" => 3})
  end

  it "is an empty has when no data is given" do
    cart = Cart.new(nil)
    expect(cart.data).to eq({})
  end

  xit "can have an item added" do

  end
end

