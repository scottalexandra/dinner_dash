require "rails_helper"

RSpec.describe CartsController, type: :controller do
  xit "has a session cart which is a hash" do
  end

  xit "sets session cart to cart data" do
    post "/carts"
    expect(session[:cart]).to eq({})
  end
end
