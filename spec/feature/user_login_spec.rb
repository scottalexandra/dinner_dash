require "rails_helper"

describe "a user" do
  before(:each) do
    visit root_path
    click_link_or_button "Log In"
  end

  it "can log in if registered" do
    User.create(first_name: "Rich",
                last_name: "Shea",
                email: "rich.shea@gmail.com",
                display_name: "Rich",
                password: "password")
    fill_in "session[email]", with: "rich.shea@gmail.com"
    fill_in "session[password]", with: "password"
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
  end

  it "can not login with invalid credentials" do
    user = User.create(first_name: "Bryce",
                       last_name: "Holcomb",
                       email: "bryce@gmail.com",
                       password: "password")

    expect(user).to be_valid
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "invalid password"
    click_link_or_button "Submit"
    expect(current_path).to eq(login_path)
    within("#flash_error") do
      expect(page).to have_content("Invalid Login Credentials")
    end
  end
end
