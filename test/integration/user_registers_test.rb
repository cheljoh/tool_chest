require 'test_helper'

class UserRegistersForAccountTest < ActionDispatch::IntegrationTest #could make FeatureTest module
  include Capybara::DSL
  test "valid user sees name on dashboard" do
    visit '/'
    click_on "register"
    fill_in "Username", with: "chelsea"
    fill_in "Password", with: "password"
    click_on "Create Account"
    user = User.last
    assert_equal "/users/#{user.id}", current_path #or could do user_path(user)
    assert page.has_content? "Hello Chelsea"
  end
end
