require "rails_helper"

describe "authenticated" do
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

  context "user" do

    it "can add them self to the system" do
      expect(page).to have_content("Log In")
      click_link_or_button "Sign Up"
      fill_in "user_first_name", with: "Kit"
      fill_in "user_last_name", with: "Pearson"
      fill_in "user_email", with: "kit@kit.com"
      fill_in "user_display_name", with: "hal9000"
      fill_in "user_password", with: "password"
      click_link_or_button "Submit"
      expect(page).to have_content("Log Out")
      expect(page).to_not have_content("Log In")
      within("#flash_notice") do
        expect(page).to have_content("User created successfully.")
      end
    end

    it "can log in if registered" do
      user_log_in("secret")
      expect(current_path).to eq(root_path)
      within("#flash_notice") do
        expect(page).to have_content("Successfully Logged In")
      end
    end

    it "can not login with invalid credentials" do
      user_log_in("incorect_password")
      expect(current_path).to eq(login_path)
      within("#flash_error") do
        expect(page).to have_content("Invalid Login Credentials")
      end
    end

    it "can log out" do
      user_log_in("secret")
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

  context "admin" do
    let!(:admin) do
      Admin.create(first_name: "Rich",
                   last_name: "Shea",
                   email: "bryce@gmail.com",
                   password: "adminpassword")
    end

    let!(:admin2) do
      Admin.create(first_name: "Rich",
                   last_name: "Shea",
                   email: "rich@gmail.com",
                   password: "adminpassword")
    end

    it "can login" do
      visit(login_path)
      fill_in "Email",    with: "bryce@gmail.com"
      fill_in "Password", with: "adminpassword"
      click_link_or_button "Submit"
      expect(page).to have_content("Welcome Rich")
    end

    it "can not view other admins profile" do
      allow_any_instance_of(ApplicationController).to receive(:current_admin).
                                                   and_return(admin2)

      visit(admin_path(admin))
    end

    it "can create a new admin" do
      visit(new_admin_path(admin))
      click_link_or_button "New Admin"
      fill_in "admin_first_name", with: "Kit"
      fill_in "admin_last_name", with: "Pearson"
      fill_in "admin_email", with: "kit@kit.com"
      fill_in "admin_password", with: "password"
      click_link_or_button "Submit"
      within("#flash_notice") do
        expect(page).to have_content "Admin created successfully."
      end
    end

  end

  def user_log_in(password)
    fill_in "session[email]", with: "bryce@gmail.com"
    fill_in "session[password]", with: password
    click_link_or_button "Submit"
  end

end
