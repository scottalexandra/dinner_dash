require "rails_helper"

describe "an admin" do
  include Capybara::DSL

  let!(:admin) do
    Admin.create(first_name: "Bryce",
                 last_name: "Holcomb",
                 email: "bryce@gmail.com",
                 password: "password")
  end

  let!(:admin2) do
    Admin.create(first_name: "Rich",
                 last_name: "Shea",
                 email: "rich@gmail.com",
                 password: "adminpassword")
  end

  it "can create a new admin" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit root_path
    click_link_or_button "New Admin"
    fill_in "admin_first_name", with: "Kit"
    fill_in "admin_last_name", with: "Pearson"
    fill_in "admin_email", with: "kit@kit.com"
    fill_in "admin_password", with: "password"
    click_link_or_button "Submit"
    within("#flash_notice") do
      expect(page).to have_content "Admin created successfully."
    end
  end

  it "can not view other admins profile" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)

    visit(admin_path(admin2))
    expect(current_path).to eq(not_found_path)
  end

  it "can create item listings including name, description, price, and category" do
    Category.create(name: "Breakfast")
    Category.create(name: "Brunch")
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit new_admin_item_path
    fill_in "item[title]", with: "New Item"
    fill_in "item[description]", with: "Description"
    fill_in "item[price]", with: "1000"
    select "Breakfast", from: "item_categories"
    select "Brunch", from: "item_categories"
    click_link_or_button "Create Item"
    within("#flash_notice") do
      expect(page).to have_content("Successfully Created")
    end
    within(".item") do
      expect(page).to have_content("New Item")
      expect(page).to have_content("Description")
      expect(page).to have_content("$10.00")
      expect(page).to have_content("Breakfast")
    end
  end

  xit "cannot create an item with invalid params" do
  end

  xit "can create an item listing and attach it to a category" do
  end

  xit "can create an item listing with a photo" do
  end

  it "can modify existing items’ name, description, price, and category" do
    Category.create(name: "Brunch")
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item.categories << category
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit item_path(item)
    click_link_or_button "Edit"
    expect(current_path).to eq(edit_admin_item_path(item))
    fill_in "item[title]", with: "Eggs"
    fill_in "item[description]", with: "a different description"
    fill_in "item[price]", with: "2000"
    select "Brunch", from: "item_categories"
    click_link_or_button "Update Item"
    expect(page).to have_content("Successfully Updated")
    expect(page).to have_content("Eggs")
    expect(page).to have_content("a different description")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("Brunch")
    expect(page).to have_content("Breakfast")
  end

  it "can create named categories for items" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit new_admin_category_path
    fill_in "category[name]", with: "Breakfast"
    click_link_or_button "Create"
    within("#flash_notice") do
      expect(page).to have_content("Successfully Created")
    end
    within(".category") do
      expect(page).to have_content("Breakfast")
    end
  end

  xit "cannot create a category with invalid params" do
  end

  it "can remove items from categories on index page" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item2 = Item.create(title: "Eggs",
                        description: "another",
                        price: 2000)
    category.items << [item, item2]
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit categories_path
    expect(page).to have_content("Bacon")
    expect(page).to have_content("desc")
    expect(page).to have_content("$10.00")
    within("#Bacon") do
      click_link_or_button "Remove from Category"
    end
    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Successfully Removed Item from Breakfast")
    expect(page).to_not have_content("Bacon")
    expect(page).to_not have_content("desc")
    expect(page).to_not have_content("$10.00")
  end

  it "can remove items from categories on show page" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item2 = Item.create(title: "Eggs",
                        description: "another",
                        price: 2000)
    category.items << [item, item2]
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit category_path(category)
    expect(page).to have_content("Bacon")
    expect(page).to have_content("desc")
    expect(page).to have_content("$10.00")
    within("#Bacon") do
      click_link_or_button "Remove from Category"
    end
    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Successfully Removed Item from Breakfast")
    expect(page).to_not have_content("Bacon")
    expect(page).to_not have_content("desc")
    expect(page).to_not have_content("$10.00")
  end

  it "can get to the admin items index page to edit them" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    category.items << item
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit admin_items_path
    expect(page).to have_content("Bacon")
    expect(page).to have_content("desc")
    expect(page).to have_content("$10.00")
    expect(page).to have_content("Breakfast")
    click_link_or_button "Edit"
    expect(current_path).to eq(edit_admin_item_path(item))
  end

  it "retire an item from being sold, which hides it from non-administrator" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item.categories << category
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit categories_path
    within(".item") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
    end
    within("#Bacon") do
      click_link_or_button "Hide"
    end
    expect(page).to have_content("Item Successfully Hidden")
    within(".shown_items") do
      expect(page).to_not have_content("Bacon")
      expect(page).to_not have_content("desc")
      expect(page).to_not have_content("$10.00")
    end
    within(".hidden_items") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
    end
  end

  it "can retire an item from the category show page" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item.categories << category
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit category_path(category)
    within(".item") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
    end
    within("#Bacon") do
      click_link_or_button "Hide"
    end
    expect(page).to have_content("Item Successfully Hidden")
    within(".shown_items") do
      expect(page).to_not have_content("Bacon")
      expect(page).to_not have_content("desc")
      expect(page).to_not have_content("$10.00")
    end
    within(".hidden_items") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
    end
  end

  it "can reveal an item previously hidden from cat index page" do
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000,
                       status: "hidden")
    item.categories << category
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                 and_return(admin)
    visit categories_path
    within(".hidden_items") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
      click_link_or_button "Reveal"
    end
    within(".shown_items") do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("desc")
      expect(page).to have_content("$10.00")
    end
    expect(Item.hidden).to eq([])
  end

  context "can view a dashboard with" do

    it "the total number of orders by status" do
    end

    xit "links for each individual order" do
    end

    xit "filter orders to display by status type (for statuses 'ordered', 'paid', 'cancelled', 'completed')" do
    end

    context "a link to" do
      xit "to 'cancel' individual orders which are currently 'ordered' or 'paid'" do
      end

      xit "'mark as paid' orders which are 'ordered'" do
      end

      xit "'mark as completed' individual orders which are currently 'paid'" do
      end

      xit "'cancel' individual orders which are currently 'ordered' or 'paid'" do
      end
    end

    context "access details of an individual order, including:" do
      xit "order date and time" do
      end

      xit "purchaser full name and email address" do
      end
      context "For each item on the order:" do
        xit "Name linked to the item page" do
        end

        xit "Quantity" do
        end

        xit "Price" do
        end

        xit "Line item subtotal" do
        end
      end

      xit "Total for the order" do
      end

      xit "Status of the order" do
      end
    end
  end

  xit "cannot modify any personal data aside from their own" do
  end
end
