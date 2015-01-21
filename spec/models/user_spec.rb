require 'rails_helper'


RSpec.describe User, :type => :model do
  let!(:valid_user) { User.create(first_name: "Alice", last_name: "Smith", email: "kit@kit.com") }

  it "is valid" do
    expect(valid_user).to be_valid 
  end

  it "is not valid without a first and last name" do
    invalid_user1 = User.new(first_name: "Alice", last_name: "", email: "kit@kit.com") 
    invalid_user2 = User.new(first_name: "", last_name: "Smith", email: "kit@kit.com") 
    expect(invalid_user1).to_not be_valid 
    expect(invalid_user2).to_not be_valid 
  end

  it "is not valid without email" do
    invalid_user1 = User.new(first_name: "Alice", last_name: "Smith", email: "") 
    invalid_user2 = User.new(first_name: "Alice", last_name: "Smith", email: "kitAtkit.com") 
    expect(invalid_user1).to_not be_valid
    expect(invalid_user2).to_not be_valid
  end

  it "is not valid with duplicate email" do
    invalid_user = User.new(first_name: "Sam", last_name: "Anderson", email: "kit@kit.com") 
    expect(invalid_user).to_not be_valid
  end

  it "is not valid if user_name to short" do
    valid_user.user_name = "k" 
    expect(valid_user).to_not be_valid
  end
end
