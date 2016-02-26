require "test_helper"

class ToolCreationTest < ActionDispatch::IntegrationTest

  test "user can create a tool" do
    user = User.create(username: "chelsea", password: "password")
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"

    visit new_tool_path

    fill_in "Name", with: "Screwdriver"
    fill_in "Price", with: "10.99"
    fill_in "Quantity", with: "10"
    click_button "Create Tool"

    assert_equal current_path, tool_path(Tool.last)

    within(".tool_info") do
      assert page.has_content?("Screwdriver")
      assert page.has_content?("0.1") #since we are dividing by 100.00
      assert page.has_content?("10")
    end
  end

  test "user can choose a category" do
    user = User.create(username: "chelsea", password: "password")
    Category.create(name: "cool")

    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"

    visit new_tool_path

    fill_in "Name", with: "Screwdriver"
    fill_in "Price", with: "10.99"
    fill_in "Quantity", with: "10"

    select 'cool', from: 'tool[category_id]'
    click_button "Create Tool"

    assert page.has_content? "cool"
  end
end
