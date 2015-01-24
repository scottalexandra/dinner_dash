require "rails_helper"

describe "An unauthenticated user" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }

  before(:each) do
    category1.items.create(title: "Bacon and Eggs",
                           description: "The classic breakfast dish",
                           price: 1000)
    category2.items.create(title: "BLT",
                           description: "The classic lunch dish",
                           price: 1000)
    visit root_path
  end

  it "can browse all items" do
    click_link_or_button "Browse all Items"
    expect(current_path).to eq(items_path)
    within("div.items") do
      within("div#item-1") do
        expect(page).to have_content "Bacon and Eggs"
        expect(page).to have_content "The classic breakfast dish"
      end
      within("div#item-2") do
        expect(page).to have_content "BLT"
        expect(page).to have_content "The classic lunch dish"
      end
    end
  end

  xit "can browse by categories" do
    click_link_or_button "Browse by Categories"
    expect(current_path).to eq(categories_path)
    within("div.categories") do
      within("div#category-1") do
        expect(page).to have_content category1.name
        expect(page).to have_content "Bacon and Eggs"
      end
      within("div#category-2") do
        expect(page).to have_content category2.name
        expect(page).to have_content "BLT"
      end
    end
  end

  it "can add an item to a cart" do
    click_link_or_button "Browse by Categories"
    within(".categories") do
      within("div#category-3") do
        within("li:first") do
          click_button "Add to Cart"
        end
      end
    end
    within("div#cart-contents") do
      expect(page).to have_content("1")
    end
  end

  it "can add two items to a cart" do
    click_link_or_button "Browse by Categories"
    within(".categories") do
      within("div#category-5") do
        within("li:first") do
          click_button "Add to Cart"
        end
      end
    end
    within(".categories") do
      within("div#category-6") do
        within("li:first") do
          click_button "Add to Cart"
        end
      end
    end
    within("div#cart-contents") do
      expect(page).to have_content("2")
    end
  end
end
