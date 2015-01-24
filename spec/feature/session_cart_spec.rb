require "rails_helper"

describe "A session cart" do
  include Capybara::DSL

  it "instantiates a cart with a controller action" do
    visit root_path
    save_and_open_page
    within("div#cart-contents") do
      expect(page).to have_content("0")
    end
  end
end
