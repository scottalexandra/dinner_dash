require "rails_helper"

RSpec.describe CartsController, type: :controller do
  it "has a session cart which is a hash" do
    expect(session[:cart]).to eq({})
  end
end
