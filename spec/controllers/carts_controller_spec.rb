require "rails_helper"

RSpec.describe CartsController, type: :controller do
  it "has a session cart which is a hash" do
  end

  it "sets session cart to cart data" do
    post "/carts"
    expect(session[:cart]).to eq({})
  end
end
