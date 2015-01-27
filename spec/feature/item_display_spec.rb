require "rails_helper"

describe "An unauthenticated user" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }
  let(:category3) { Category.create(name: "Dessert") }

  before(:each) do
    category1.items.create(title: "Bacon and Eggs",
    description: "The classic breakfast dish",
    price: 1000, image: "bacon_and_eggs.jpg")
    category2.items.create(title: "BLT",
    description: "The classic lunch dish",
    price: 1000, image: "blt.jpg")
    category3.items.create(title: "Bacon Ice Cream",
    description: "Very delicious",
    price: 5000, image: "bacon_ice_cream.jpg")
    visit root_path
  end

  it "can view items with image" do
    click_link_or_button "Menu"
    within("div.categories") do
      within("div#Lunch") do
        within("div.item") do
          within("div#image") do
            expect(page).to have_selector('img[alt="Blt"]')
          end
        end
      end
    end
  end

end
