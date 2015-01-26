require "rails_helper"

describe "an admin" do
  include Capybara::DSL

  it "create item listings including name, description, price, and category" do
    Category.create(name: "Breakfast")
    Category.create(name: "Brunch")
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

  xit "can create an item listing with a photo" do
    # add this to the first spec
  end

  it "modify existing items’ name, description, price, and category" do
    Category.create(name: "Brunch")
    category = Category.create(name: "Breakfast")
    item = Item.create(title: "Bacon",
                       description: "desc",
                       price: 1000)
    item.categories << category
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

  it "create named categories for items" do
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

  xit "assign items to categories or remove them from categories. Products can belong to more than one category" do
  end

  xit "retire a item from being sold, which hides it from browsing by any non-administrator" do
  end

  context "can view a dashboard with" do
    xit "the total number of orders by status" do
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


