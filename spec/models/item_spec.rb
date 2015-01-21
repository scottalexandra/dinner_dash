require 'rails_helper'

RSpec.describe Item, :type => :model do

  it "is valid" do
    item = Item.new
    expect(item).to_not be_valid
  end

  it "is not valid without title" do
    item = Item.new(title: nil, description: "new description", price: 2000)
    expect(item).to_not be_valid
  end

  it "is not valid without description" do
    item = Item.new(title: "NewTitle", description: nil, price: 2000)
    item2 = Item.new(title: "NewTitle", description: "", price: 2000)
    expect(item).to_not be_valid
    expect(item2).to_not be_valid
  end

  it "is not valid without price" do
    item = Item.new(title: "NewTitle",
                    description: "new description",
                    price: nil)
    expect(item).to_not be_valid
  end

  it "is not valid without unique title" do
    item = Item.create(title: "NewTitle",
                       description: "new description",
                       price: 1000)
    item2 = Item.new(title: "NewTitle",
                     description: "newer description",
                     price: 1000)
    expect(item2).to_not be_valid
  end

  it "is not valid if price is not greater than zero" do
    item = Item.create(title: "item",
                       description: "item description",
                       price: 0)
    expect(item).to_not be_valid
  end

  it "is not valid without an integer price" do
    item = Item.create(title: "another item",
                       description: "item description",
                       price: "werwsd")
    expect(item).to_not be_valid
  end

  it "shows the correct count with database cleaner" do
    Item.create(title: "next item",
                       description: "desc",
                       price: 2000)
    expect(Item.count).to eq(1)
  end
end
