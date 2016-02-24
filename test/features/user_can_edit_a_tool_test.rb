require 'test_helper'

class UserCanEditAToolTest < ActionDispatch::IntegrationTest

  test "user can edit an existing tool" do
    user = User.create(username: "chelsea", password: "password")
    tool = user.tools.create(name: "hammer", price: 20, quantity: 10)
    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_on "Login"

    visit edit_tool_path(tool.id)

    fill_in "Name", with: "wrench"
    fill_in "tool[quantity]", with: "3" #same as saying label- underlying HTML is the tool[quantity]
    fill_in "Price", with: "2000"
    click_link_or_button "Update Tool"

    assert_equal current_path, tool_path(tool.id)

    within(".tool_info") do
      assert page.has_content?("wrench")
      assert page.has_content?("3")
      assert page.has_content?("20.0")
    end
  end

end
