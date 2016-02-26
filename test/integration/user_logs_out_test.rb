require 'test_helper'

class UserLogsOutTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  test "valid user sees log out message after logging out" do
    user = User.create(username: "chelsea", password: "password")
    visit '/'
    click_on 'login'
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"


    assert page.has_content? "Hello Chelsea"

    visit '/'

    click_link "logout"

    refute page.has_content? "Hello chelsea"
  end
end
