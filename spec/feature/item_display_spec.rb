require "rails_helper"

describe "items can be viewed" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }
  let(:category3) { Category.create(name: "Dessert") }

  before(:each) do
    path = 'app/assets/images/'
    category1.items.create(title: "Bacon and Eggs",
                           description: "The classic breakfast dish",
                           price: 1000,
                           image: open(path + "bacon_and_egg_cups.jpg"))
    category2.items.create(title: "BLT",
                           description: "The classic lunch dish",
                           price: 1000,
                           image: open(path + "blt.jpg"))
    category3.items.create(title: "Bacon Ice Cream",
                           description: "Very delicious",
                           price: 5000,
                           image: open(path + "bacon_ice_cream.jpg"))
    visit root_path
  end

  context 'as a guest user' do
    it "can view an items image" do
      click_link_or_button "Menu"
      expect(page).to have_css('img[src*="bacon_and_egg"]')
    end
  end
end
