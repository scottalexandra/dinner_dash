require 'rails_helper'

RSpec.describe Item, :type => :model do
    @category  = Category.create(name: "NewCategory")
    @category2 = Category.create(name: "NewCategory2")
  let!(:valid_item) do
    @category  = Category.create(name: "NewCategory")
    @category2 = Category.create(name: "NewCategory2")
    item = Item.new(title: "title", description: "desc", price: 10)
    item.categories << @category2
    item.categories << @category
    item.save
    item
  end

  it "is valid" do
    expect(valid_item).to be_valid
  end

  context "is not valid without" do
    it "without title" do
      item = Item.new(title: nil, description: "new description", price: 2000)
      item.categories << @category
      expect(item.save).to eq false
    end

    it "description" do
      item = Item.new(title: "NewTitle", description: nil, price: 2000)
      item2 = Item.new(title: "NewTitle", description: "", price: 2000)
      item.categories << @category
      item2.categories << @category
      expect(item.save).to eq false
      expect(item.save).to eq false
      expect(item).to_not be_valid
      expect(item2).to_not be_valid
    end

    it "price" do
      item = Item.new(title: "NewTitle",
                      description: "new description",
                      price: nil)
      item.categories << @category
      expect(item.save).to eq false
    end

    it "unique title" do
      item = Item.create(title: "NewTitle",
                  description: "new description",
                  price: 1000)
      item.categories << @category
      item2 = Item.new(title: "NewTitle",
                       description: "newer description",
                       price: 1000)
      expect(item2).to_not be_valid
    end

    it "a grater than zero" do
      item = Item.create(title: "item",
                         description: "item description",
                         price: 0)
      item.categories << @category
      expect(item.save).to eq false
    end

    it "an integer price" do
      item = Item.create(title: "another item",
                         description: "item description",
                         price: "werwsd")
      item.categories << @category
      expect(item.save).to eq false
    end

    it "a status" do
      item = Item.create(title: "another item",
                         description: "item description",
                         status: nil,
                         price: 1000)
      item.categories << @category
      expect(item.save).to eq false
    end

    it "an associated category" do
      categoryless_item = valid_item.categories.delete @category
      expect(categoryless_item).to_not be_valid
    end
  end

  it "can have hidden items" do
    valid_item.status = "hidden"
    valid_item.save
    expect(Item.hidden.count).to eq(1)
  end

  it "can belong to an order" do
    item = Item.new

    expect(item.orders).to eq([])
  end

  it "has an order" do
    order = Order.new(user_id: 1)
    order.items << valid_item
    order.save
    expect(order.items.first).to eq(valid_item)
  end

  it "shows the correct count with database cleaner" do
    Item.create(title: "next item",
                description: "desc",
                price: 2000)
    expect(Item.count).to eq(1)
  end

  it "has a currency that converts cents to dollars" do
    item = Item.create(title: "next item",
                       description: "desc",
                       price: 2000)

    expect(item.currency).to eq(20)
  end
end
