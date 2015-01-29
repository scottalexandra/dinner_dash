require "rails_helper"

RSpec.describe User, type: :model do
  let!(:valid_user) do
    User.create(first_name: "Alice",
                last_name: "Smith",
                email: "kit@kit.com",
                password: "password")
  end

  it "is valid" do
    expect(valid_user).to be_valid
  end

  it "is not valid without a first and last name" do
    invalid_user1 = User.new(first_name: "Alice",
                             last_name: "",
                             email: "kit@kit.com",
                             password: "password")

    invalid_user2 = User.new(first_name: "",
                             last_name: "Smith",
                             email: "kit@kit.com",
                             password: "password")
    expect(invalid_user1).to_not be_valid
    expect(invalid_user2).to_not be_valid
  end

  it "is not valid without email" do
    invalid_user1 = User.new(first_name: "Alice",
                             last_name: "Smith",
                             email: "",
                             password: "password")

    invalid_user2 = User.new(first_name: "Alice",
                             last_name: "Smith",
                             email: "kitAtkit.com",
                             password: "password")
    expect(invalid_user1).to_not be_valid
    expect(invalid_user2).to_not be_valid
  end

  it "is not valid with duplicate email" do
    invalid_user = User.new(first_name: "Sam",
                            last_name: "Anderson",
                            email: "kit@kit.com",
                            password: "password")
    expect(invalid_user).to_not be_valid
  end

  it "is not valid if display_name to short" do
    valid_user.display_name = "k"
    expect(valid_user).to_not be_valid
  end

  it "can have orders" do
    expect(valid_user.orders).to eq([])
  end

  it "can be assigned a specific order" do
    order = Order.new(user_id: valid_user.id)
    order.save
    expect(valid_user.orders.first).to eq(order)
  end
end
