require 'test_helper'

class UserLogsInTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  test "valid user sees name on dashboard after logging in" do
    user = User.create(username: "chelsea", password: "password")
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"

    assert page.has_content? "Hello Chelsea"
  end
end

#need sad path for if user hasn't registered
