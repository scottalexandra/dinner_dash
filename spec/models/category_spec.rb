require 'rails_helper'

RSpec.describe Category, :type => :model do

  it "can have items" do
    category = Category.new
    expect(category.items).to eq([])
  end

  it "has an item" do
    category = Category.create(name: "NewCategory")
    item = category.items.create(title: "NewTitle", description: "new description", price: 2000)
    expect(category.items.first.title).to eq("NewTitle")
  end

end
