require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:item) do
    @category = Category.create(name: "NewCategory")
    item = Item.new(title: "NewTitle",
                    description: "new description",
                    price: 2000)
    item.categories << @category
    item.save
    item
  end

  it "can have items" do
    expect(@category.items).to eq([item])
  end

  it "has an item" do
    expect(@category.items.first.title).to eq("NewTitle")
  end

  it "shows only the items with status of show" do
    item2 = Item.create(title: "Another",
                        description: "another description",
                        price: 2000,
                        status: "hidden")
    item2.categories << @category
    item.save
    expect(@category.items.count).to eq(1)
    expect(@category.items.include?(item2)).to eq(false)
  end
end
