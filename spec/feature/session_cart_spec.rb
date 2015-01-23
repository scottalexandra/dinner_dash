require "rails_helper"

describe "A session cart" do
  include Capybara::DSL

  it "instantiates a cart with a controller action" do
    visit root_path
    expect(session[:cart]).to eq({})
  end
end
