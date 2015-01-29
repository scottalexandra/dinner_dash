require "rails_helper"

describe "an authenticated user" do
  include Capybara::DSL

  let!(:category1) { Category.create(name: "Breakfast") }
  let!(:category2) { Category.create(name: "Lunch") }
  let!(:valid_user) do
    User.create(first_name: "Alice",
                last_name: "Smith",
                email: "rich@gmail.com",
                password: "password")
  end

  before(:each) do
    item = Item.new(title: "Bacon and Eggs",
                    description: "The classic breakfast dish",
                    price: 1000)
    item.categories << category1
    item.save

    item = Item.new(title: "BLT",
                    description: "The classic lunch dish",
                    price: 1000)
    item.categories << category2
    item.save

    visit root_path
  end

  it "can browse all items grouped by category (category index page)" do
    valid_user_logs_in
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
    visit new_order_path
    within("#item_1") do
      click_link "Remove From Cart"
    end
    within("#cart-contents") do
      expect(page).to have_content("0")
    end
    expect(current_path).to eq(new_order_path)
    expect(page).to_not have_content("Bacon")
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
      expect(page).to have_content("Bacon")
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

  it "can view past orders with links to each order" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    Order.create(user_id: valid_user.id)
    Order.create(user_id: valid_user.id)
    visit user_path(valid_user.id)
    click_link_or_button "View past orders"
    expect(current_path).to eq(orders_path)
    within(".orders-list") do
      expect(page).to have_content("Order 00001")
    end
  end

  it "can view particular orders (order show page)" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
    and_return(valid_user)
    Order.create(user_id: valid_user.id)
    visit user_path(valid_user.id)
    click_link_or_button "View past orders"
    click_link_or_button "Order 00001"
    expect(page).to have_content("Order 00001")
  end

  context "can view the order page with" do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(valid_user)
      click_add_to_cart_link("Breakfast")
      click_link_or_button "Cart:"
      click_link_or_button "Checkout"
    end

    it "items with quantity ordered and line-item subtotals" do
      within("#item-quantity") do
        expect(page).to have_content("1")
      end
      within("#item-subtotal") do
        expect(page).to have_content("$10.00")
      end
    end

    it "items with links to each item description page" do
      within("#item-title") do
        click_link_or_button "Bacon"
      end
      expect(page).to have_content("Bacon")
    end

    it "the current status of the order" do
      within("#order-status") do
        expect(page).to have_content("ordered")
      end
    end

    it "order total price" do
      within("#item-total") do
        expect(page).to have_content("$10.00")
      end
    end

    it "date/time order was submitted" do
      within("#order-submit-time") do
        expect(page).to have_content("Order submitted at:")
      end
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    visit root_path
    expect(page).to have_content("Categroies")
    visit edit_admin_category_path(category1)
    expect(page).to have_content("Page Not Found")
  end

  it "cannot make themselves an admin" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                    and_return(valid_user)
    visit new_admin_path
    expect(page).to have_content("Page Not Found")
  end

  def click_add_to_cart_link(category)
    click_link_or_button "Menu"
    within(".categories") do
      within("div##{category}") do
          click_link "Add to Cart"
      end
    end
  end

  def valid_user_logs_in
    fill_in "session_email", with: "rich@gmail.com"
    fill_in "session_password", with: "password"
    click_link_or_button "Log In"
  end
end
