require "rails_helper"

describe "items viewed" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }
  let(:category3) { Category.create(name: "Dessert") }

  before(:each) do
    path = 'app/assets/images/'
    item = Item.new(title: "Bacon and Eggs",
                    description: "The classic breakfast dish",
                    price: 1000,
                    image: open(path + "bacon_and_egg_cups.jpg"))
    item.categories << category1
    item.save
    item2 = Item.new(title: "BLT",
                     description: "The classic lunch dish",
                     price: 1000,
                     image: open(path + "blt.jpg"))
    item2.categories << category2
    item2.save
    item3 = Item.new(title: "Bacon Ice Cream",
                     description: "Very delicious",
                     price: 5000,
                     image: open(path + "bacon_ice_cream.jpg"))
    item3.categories << category3
    item3.save

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
  end
end
