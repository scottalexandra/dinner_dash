require "rails_helper"

describe "items viewed" do
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
    click_link_or_button "Menu"
  end

  context 'by a guest user' do
    it "can see an items image" do
      expect(page).to have_css('img[src*="bacon_and_egg"]')
    end

    it "can see title and discription" do
      expect(page).to have_content("Bacon and Eggs")
      expect(page).to have_content("The classic breakfast dish")
    end

    xit "can be added to the cart" do
      within("#cart-contents") do
        expect(page).to have_content("0")
      end
      save_and_open_page
      within(".item#Bacon") do
        click_link_or_button "Add to Cart"
      end
      within("#cart-contents") do
        expect(page).to have_content("1")
      end
    end
  end

  context "as a logged in user" do
    it "does something" do

    end

  # allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 # and_return(admin)

  end
end
