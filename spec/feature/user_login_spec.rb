require "rails_helper"

describe "a user" do

  let!(:user) do
    User.create(first_name: "Rich",
                last_name: "Shea",
                email: "bryce@gmail.com",
                display_name: "Rich",
                password: "secret")
  end

  before(:each) do
    visit root_path
    click_link_or_button "Log In"
  end

  it "can log in if registered" do
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "secret"
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
  end

  it "can not login with invalid credentials" do
    fill_in "session[email]", with: "rich.shea@gmail.com"
    fill_in "session[password]", with: "invalid password"
    click_link_or_button "Submit"
    expect(current_path).to eq(login_path)
    within("#flash_error") do
      expect(page).to have_content("Invalid Login Credentials")
    end
  end

  it "can log out" do
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "secret"
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
    click_link_or_button "Log Out"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged Out")
    end
  end

end
