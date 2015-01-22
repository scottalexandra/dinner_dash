require "rails_helper"

describe "an authenticated user" do

  it "can view their own page" do
    user = User.create(first_name: "Alice",
                       last_name: "Smith",
                       email: "rich.shea@gmail.com",
                       password: "password")
    allow_any_instance_of(ApplicationController)
                                  .to receive(:current_user).and_return(user)
    visit user_path(user)
    expect(current_path).to eq(user_path(user))
  end

  it "cannot view another users private data" do
    user = User.create(first_name: "Alice",
                       last_name: "Smith",
                       email: "rich.shea@gmail.com",
                       password: "password")
    allow_any_instance_of(ApplicationController)
                                   .to receive(:current_user).and_return(user)
    user2 = User.create(first_name: "Bob",
                        last_name: "Smith",
                        email: "abcdef@kit.com",
                        password: "password123")
    visit user_path(user2)
    expect(current_path).to eq(not_found_path)
  end

end
