require "rails_helper"

describe "an admin" do
  include Capybara::DSL

  it "create item listings including a name, description, price, and upload a photo" do
    category = Category.create(name: "Breakfast")
    visit new_admin_item_path
    fill_in "session[title]", with: "New Item"
    fill_in "session[description]", with: "Description"
    fill_in "session[price]", with: "$10.00"
    select category.name, :from => "category-dropdown"
    click_link_or_button "Create"
    expect(current_path).to eq(item_path(item))
    within("#flash_notice") do
      expect(page).to have_content("Successfully Created")
    end
  end

  xit "modify existing items’ name, description, price, and photo" do
  end

  xit "create named categories for items" do
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


