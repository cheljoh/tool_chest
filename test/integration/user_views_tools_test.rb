require 'test_helper'

class UserViewsToolsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  test "valid user sees name on dashboard after logging in" do
    user = User.create(username: "chelsea", password: "password")
    tool = user.tools.create(name: "hammer", price: 20, quantity: 10)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"

    assert page.has_content? "hammer"
  end
end
