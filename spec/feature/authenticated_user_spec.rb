require "rails_helper"

describe "an authenticated user" do
  include Capybara::DSL

  let(:category1) { Category.create(name: "Breakfast") }
  let(:category2) { Category.create(name: "Lunch") }
  let!(:valid_user) do
    User.create(first_name: "Alice",
                last_name: "Smith",
                email: "rich@gmail.com",
                password: "password")
  end

  before(:each) do
    category1.items.create(title: "Bacon and Eggs",
                           description: "The classic breakfast dish",
                           price: 1000)
    category2.items.create(title: "BLT",
                           description: "The classic lunch dish",
                           price: 1000)
    visit root_path
  end

  it "can browse all items grouped by category (category index page)" do
    valid_user_logs_in
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

  xit "can browse items for a specific category (category show page)" do
  end

  it "can add an item to a cart" do
    valid_user_logs_in
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

  it "can view their own page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    visit user_path(valid_user)
    expect(current_path).to eq(user_path(valid_user))
  end

  it "cannot view another users private data" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    user2 = User.create(first_name: "Bob",
                        last_name: "Smith",
                        email: "abcdef@kit.com",
                        password: "password123")
    visit user_path(user2)
    expect(current_path).to eq(not_found_path)
  end

  it "cannot view admin dashboard" do
    admin = Admin.create(first_name: "First",
                         last_name: "Last",
                         email: "admin@gmail.com",
                         password: "adminpassword")
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    visit admin_path(admin)
    expect(current_path).to eq(not_found_path)
  end

  it "can log in and out without clearing the cart" do
    within("#cart-contents") do
      expect(page).to have_content("0")
    end
    click_add_to_cart_link("Breakfast")
    valid_user_logs_in
    expect(current_path).to eq(root_path)
    within("#cart-contents") do
      expect(page).to have_content("1")
    end
    click_add_to_cart_link("Breakfast")
    click_link_or_button "Log Out"
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged Out")
    end
    within("#cart-contents") do
      expect(page).to have_content("2")
    end
  end

  it "checkout" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    click_add_to_cart_link("Breakfast")
    click_link_or_button "Cart:"
    click_link_or_button "Checkout"
    within("#flash_notice") do
      expect(page).to have_content("Your delicious food is on the way")
    end
  end

  it "can view their order after checkout" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    click_add_to_cart_link("Breakfast")
    click_link_or_button "Cart:"
    click_link_or_button "Checkout"
    within("#item-title") do
      expect(page).to have_content("Bacon and Eggs")
    end
    within("#item-description") do
      expect(page).to have_content("The classic breakfast dish")
    end
    within("#item-quantity") do
      expect(page).to have_content("1")
    end
    within("#item-price") do
      expect(page).to have_content("$10.00")
    end
    within("#item-subtotal") do
      expect(page).to have_content("$10.00")
    end
    within("#item-total") do
      expect(page).to have_content("$10.00")
    end
    within("#order-status") do
      expect(page).to have_content("ordered")
    end
  end

  xit "can view past orders with links to each order" do
  end

  xit "can view particular orders (order show page)" do
  end

  context "can view the order page with" do

    xit "items with quantity ordered and line-item subtotals" do
    end

    xit "items with links to each item description page" do
    end

    xit "the current status of the order" do
    end

    xit "order total price" do
    end

    xit "date/time order was submitted" do
    end

    xit "a timestamp when that action took place if completed or cancelled" do
    end
  end

  context ", when an item is retired," do
    xit "can still access the item page" do
    end

    xit "cannot add it to a new cart" do
    end
  end

  xit "cannot see the login button" do

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
        within("div.item") do
          click_link "Add to Cart"
        end
      end
    end
  end

  def valid_user_logs_in
    click_link_or_button "Log In"
    fill_in "session_email", with: "rich@gmail.com"
    fill_in "session_password", with: "password"
    click_link_or_button "Submit"
  end
end
