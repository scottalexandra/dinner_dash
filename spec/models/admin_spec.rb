require 'rails_helper'

RSpec.describe Admin, :type => :model do
  it "is valid" do
    admin = Admin.new(first_name: "First",
                      last_name: "Last",
                      email: "admin@gmail.com",
                      password: "password")
    expect(admin).to be_valid
  end

  it "is not valid without a first and last name" do
    invalid_admin1 = Admin.new(first_name: "",
                               last_name: "Last",
                               email: "admin@gmail.com",
                               password: "password")
    invalid_admin2 = Admin.new(first_name: "First",
                               last_name: "",
                               email: "admin@gmail.com",
                               password: "password")
    expect(invalid_admin1).to_not be_valid
    expect(invalid_admin2).to_not be_valid
  end

  it "is not valid without an email" do
    invalid_admin1 = Admin.new(first_name: "First",
                               last_name: "Last",
                               email: "",
                               password: "password")
    expect(invalid_admin1).to_not be_valid
  end

  it "is not valid without a properly formatted email" do
    invalid_admin1 = Admin.new(first_name: "First",
                               last_name: "Last",
                               email: "kitATkit.com",
                               password: "password")
    expect(invalid_admin1).to_not be_valid
  end

  it "is not valid with a duplicate email" do
    Admin.create(first_name: "First",
                 last_name: "Last",
                 email: "kit@kit.com",
                 password: "password")
    invalid_admin2 = Admin.new(first_name: "First",
                               last_name: "Last",
                               email: "kit@kit.com",
                               password: "password")
    expect(invalid_admin2).to_not be_valid
  end
end
