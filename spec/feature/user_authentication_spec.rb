require "rails_helper"

describe "User" do
  include Capybara::DSL

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

  it "can add them self to the system" do
    click_link_or_button "Sign Up"
    fill_in "user_first_name", with: "Kit"
    fill_in "user_last_name", with: "Pearson"
    fill_in "user_email", with: "kit@kit.com"
    fill_in "user_display_name", with: "hal9000"
    fill_in "user_password", with: "password"
    click_link_or_button "Submit"
    expect(current_path).to eq(user_path(params[:user]))
    within("#flash_notice") do
      expect(page).to have_content("User created successfully.")
    end
  end

  it "can log in if registered" do
    user_log_in
    click_link_or_button "Submit"
    expect(current_path).to eq(root_path)
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
  end

  it "can not login with invalid credentials" do
    user_log_in
    click_link_or_button "Submit"
    expect(current_path).to eq(login_path)
    within("#flash_error") do
      expect(page).to have_content("Invalid Login Credentials")
    end
  end

  it "can log out" do
    user_log_in
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

  def user_log_in
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: "secret"
  end

end
