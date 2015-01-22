require "rails_helper"

describe "a user" do
  it "can log in if registered" do
    User.create(first_name: "Rich",
                last_name: "Shea",
                email: "rich.shea@gmail.com",
                display_name: "Rich",
                password: "password")
    visit "/"
    click_link_or_button "Log In"
    fill_in "session[email]", with: "rich.shea@gmail.com"
    fill_in "session[password]", with: "password"
    click_link_or_button "Submit"
    expect(current_path).to eq("/")
    within("#flash_notice") do
      expect(page).to have_content("Successfully Logged In")
    end
  end
end
