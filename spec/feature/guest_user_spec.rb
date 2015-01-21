require "rails_helper"

describe "An unauthenticated user" do

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }

  before(:each) do
    category1.items.create(title: "Bacon and Eggs",
                           description: "The classic breakfast dish",
                           price: 1000)
    category2.items.create(title: "BLT",
                           description: "The classic lunch disk",
                           price: 1000)
  end

  it "can browse all items" do
    visit "/"
    click_link_or_button "Menu"
    expect(current_path).to eq("/categories")
    within("#menu") do
      expect(page).to have_content category1.name
    end
    within("ul#menu-categories") do
      expect(page).to have_content "Bacon and Eggs"
    end
  end

  xit "can see the category items" do
    click_link_or_button "Menu"
    click_link_or_button "Breakfast"
    #write the test here
  end
end
