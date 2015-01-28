require "rails_helper"

describe "An unauthenticated user" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }

  before(:each) do
    category1.items.create(title: "Bacon",
                           description: "The classic breakfast dish",
                           price: 1000, image: "bacon_and_eggs.jpg")
    category2.items.create(title: "BLT",
                           description: "The classic lunch dish",
                           price: 1000, image: "blt.jpg")
    visit root_path
  end

  it "can browse all items grouped by category (category index page)" do
    click_link_or_button "Menu"
    expect(current_path).to eq(categories_path)
    within("div.categories") do
      within("div#Breakfast") do
        expect(page).to have_content category1.name
        expect(page).to have_content "Bacon"
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
    within("#Bacon") do
      expect(page).to have_content("Bacon")
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
    visit new_order_path
    within("#Bacon") do
      click_link "Remove From Cart"
    end
    within("#cart-contents") do
      expect(page).to have_content("0")
    end
    expect(current_path).to eq(new_order_path)
    expect(page).to_not have_content("Bacon")
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

  xit "cannot see the logout button" do
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
    expect(page).to have_content("Bacon")
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
  end

  xit "cannot create an item" do
  end

  xit "cannot modify an item" do
  end

  xit "cannot assign an item to a category" do
  end

  xit "cannot remove an item from a category" do
  end

  xit "cannot create a category" do
  end

  xit "cannot modify a category" do
  end

  xit "cannot make themselves an admin" do
  end

  def click_add_to_cart_link(category)
    click_link_or_button "Menu"
    within(".categories") do
      within("div##{category}") do
        within("div.panel") do
          click_link "Add to Cart"
        end
      end
    end
  end

end
