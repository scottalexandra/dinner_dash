require "rails_helper"

describe "A session cart" do
  include Capybara::DSL

  xit "instantiates a cart with a controller action" do
    visit root_path
    expect(session[:cart]).to eq({})
  end
end
