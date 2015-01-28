require "rails_helper"

describe "An unauthenticated user" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }
  let!(:item) do
    category1.items.create(title: "Bacon and Eggs",
                           description: "The classic breakfast dish",
                           price: 1000, image: "bacon_and_eggs.jpg")
  end
  let!(:item2) do
    category2.items.create(title: "BLT",
                           description: "The classic lunch dish",
                           price: 1000, image: "blt.jpg")
  end
  let!(:valid_user) do
    User.create(first_name: "Alice",
                last_name: "Smith",
                email: "rich@gmail.com",
                password: "password")
  end

  before(:each) do
    visit root_path
  end

  it "can browse all items grouped by category (category index page)" do
    click_link_or_button "Menu"
    expect(current_path).to eq(categories_path)
    within("div.categories") do
      within("div#Breakfast") do
        expect(page).to have_content category1.name
        expect(page).to have_content "Bacon and Eggs"
      end
      within("div#Lunch") do
        expect(page).to have_content category2.name
        expect(page).to have_content "BLT"
      end
    end
  end

  it "can browse items for a specific category (category show page)" do
    click_link_or_button "Menu"
    within("div.categories") do
      click_link_or_button "Breakfast"
    end
    expect(current_path).to eq(category_path(category1.id))
    within("div.item") do
      expect(page).to have_content("Bacon and Eggs")
      expect(page).to have_content("The classic breakfast dish")
    end
  end

  it "can add an item to a cart" do
    click_add_to_cart_link("Breakfast")
    within("#cart-contents") do
      expect(page).to have_content("1")
    end
  end

  it "can add two items to a cart" do
    click_add_to_cart_link("Breakfast")
    click_add_to_cart_link("Breakfast")
    click_add_to_cart_link("Lunch")
    within("#cart-contents") do
      expect(page).to have_content("3")
    end
  end

  it "can remove an item from a cart" do
    click_add_to_cart_link("Breakfast")
    within(".categories") do
      within("div#Breakfast") do
        click_link "Remove From Cart"
      end
    end
    within("#cart-contents") do
      expect(page).to have_content("0")
    end
  end

  it "can login which does not clear cart" do
    click_add_to_cart_link("Breakfast")
    User.create(first_name: "Rich",
                last_name: "Shea",
                email: "bryce@gmail.com",
                display_name: "Rich",
                password: "secret")
    click_link_or_button "Log In"
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "secret"
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
    within("#cart-contents") do
      expect(page).to have_content("1")
    end
  end

  it "cannot see the logout button" do
    expect(page).to_not have_content("Log Out")
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    visit root_path
    expect(page).to have_content("Log Out")
  end

  it "can log out which does not clear cart" do
    click_add_to_cart_link("Breakfast")
    User.create(first_name: "Rich",
                last_name: "Shea",
                email: "bryce@gmail.com",
                display_name: "Rich",
                password: "secret")
    click_link_or_button "Log In"
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "secret"
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#cart-contents") do
      expect(page).to have_content("1")
    end
    click_link_or_button "Log Out"
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged Out")
    end
    within("#cart-contents") do
      expect(page).to have_content("1")
    end
  end

  it "can view their empty cart" do
    click_link_or_button "Cart"
    expect(current_path).to eq(new_order_path)
    expect(page).to have_content("Your cart is empty")
  end

  it "can view their cart with items" do
    click_add_to_cart_link("Breakfast")
    click_add_to_cart_link("Breakfast")
    click_link_or_button "Cart:"
    expect(current_path).to eq(new_order_path)
    expect(page).to have_content("Bacon and Eggs")
    within "div#quantity" do
      expect(page).to have_content("2")
    end
    within "div#description" do
      expect(page).to have_content("The classic breakfast dish")
    end
    within "div#price" do
      expect(page).to have_content("$10.00")
    end
  end

  it "cannot view another person's private data" do
    user = User.create(first_name: "Rich",
                       last_name: "Shea",
                       email: "bryce@gmail.com",
                       display_name: "Rich",
                       password: "secret")
    visit user_path(user)
    expect(current_path).to eq(not_found_path)
  end

  it "cannot checkout" do
    click_add_to_cart_link("Breakfast")
    click_add_to_cart_link("Breakfast")
    click_link_or_button "Cart:"
    expect(current_path).to eq(new_order_path)
    click_link_or_button "Checkout"
    expect(current_path).to eq(login_path)
    within("#flash_notice") do
      expect(page).to have_content("Please login or signup to continue with checkout")
    end
  end

  it "cannot view the admin dashboard" do
    expect(page).to_not have_content("Admin Dashboard")
  end

  it "cannot create an item" do
    visit new_admin_item_path
    expect(page).to have_content("Page Not Found")
  end

  it "cannot modify an item" do
    visit edit_admin_item_path(item)
    expect(page).to have_content("Page Not Found")
  end

  it "cannot assign an item to a category" do
    visit edit_admin_category_path(category1)
    expect(page).to have_content("Page Not Found")
    visit categories_path
    expect(page).to_not have_content("Add to Category")
  end

  it "cannot remove an item from a category" do
    visit new_admin_category_path
    expect(page).to have_content("Page Not Found")
    visit categories_path
    expect(page).to_not have_content("Remove from Category")
  end

  it "cannot create a category" do
    visit new_admin_category_path
    expect(page).to have_content("Page Not Found")
  end

  it "cannot modify a category" do
    visit edit_admin_category_path(category1)
    expect(page).to have_content("Page Not Found")
  end

  it "cannot make themselves an admin" do
    visit new_admin_path
    expect(page).to have_content("Page Not Found")
  end

  def click_add_to_cart_link(category)
    click_link_or_button "Menu"
    within(".categories") do
      within("div##{category}") do
        within("div.item") do
          click_link "Add to Cart"
        end
      end
    end
  end
end
