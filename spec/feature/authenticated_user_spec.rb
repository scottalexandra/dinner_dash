require "rails_helper"

describe "an authenticated user" do

  it "cannot view another users private data" do
    user = User.create(first_name: "Alice",
                       last_name: "Smith",
                       email: "rich.shea@gmail.com",
                       password: "password")
    # visit root_path
    # click_link_or_button "Log In"
    # fill_in "session[email]", with: "rich.shea@gmail.com"
    # fill_in "session[password]", with: "password"
    # click_link_or_button "Submit"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user2 = User.create(first_name: "Bob",
                        last_name: "Smith",
                        email: "abcdef@kit.com",
                        password: "password123")
    visit user_path(user2)
    expect(current_path).to eq(user_path(user))
    within("#flash_alert") do
      expect(page).to have_content("Not authorized")
    end
  end

end
