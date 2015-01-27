require "rails_helper"

RSpec.describe Category, type: :model do

  it "can have items" do
    category = Category.new
    expect(category.items).to eq([])
  end

  it "has an item" do
    category = Category.create(name: "NewCategory")
    item = category.items.create(title: "NewTitle",
                                 description: "new description",
                                 price: 2000)
    expect(category.items.first.title).to eq("NewTitle")
  end

  it "shows only the items with status of show" do
    category = Category.create(name: "NewCategory")
    item = category.items.create(title: "NewTitle",
                                 description: "new description",
                                 price: 2000)
    item2 = category.items.create(title: "Another",
                                  description: "another description",
                                  price: 2000,
                                  status: "hidden")
    expect(category.items.count).to eq(1)
    expect(category.items.include?(item2)).to eq(false)
  end

end
