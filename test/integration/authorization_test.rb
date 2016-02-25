require 'test_helper'

class AuthorizationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  test "admin can view categories index" do
    admin = User.create(username: "admin", password: "password", role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_categories_path
    within("#admin_categories") do
      assert page.has_content?("All Categories")
    end
  end

    test "admin can view category show" do
      admin = User.create(username: "admin", password: "password", role: 1)
      ApplicationController.any_instance.stubs(:current_user).returns(admin)
      category = Category.create(name: "outside")

      visit admin_categories_path
      click_on "outside"
      assert page.has_content?("outside")
    end

  test "user cannot view categories index" do
    user = User.create(username: "user", password: "password", role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_categories_path
    refute page.has_content?("All Categories")

  end

  test "admin can create a category" do
    admin = User.create(username: "admin", password: "password", role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit new_admin_category_path
    fill_in "Name", with: "outside"
    click_on "Save Category"
    assert page.has_content?("outside")
  end

  test "admin can edit a category" do
    admin = User.create(username: "admin", password: "password", role: 1)
    category = Category.create(name: "outside")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit edit_admin_category_path(category)
    fill_in "Name", with: "inside"
    click_on "Save Category"

    assert page.has_content?("inside")
  end

  test "admin can delete a category" do
    admin = User.create(username: "admin", password: "password", role: 1)
    category = Category.create(name: "outside")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_category_path(category)
    click_on "Delete Category"
    refute page.has_content?("outside")
    visit admin_categories_path
  end

  test "admin can see tools associated with category" do
    admin = User.create(username: "admin", password: "password", role: 1)
    category = Category.create(name: "outside")
    category.tools.create(name: "hammer", quantity: 20, price: 20)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_category_path(category)
    assert page.has_content?("hammer")
  end

  test "admin can create a tool" do
    admin = User.create(username: "admin", password: "password", role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit new_admin_tool_path

    fill_in "Name", with: "Screwdriver"
    fill_in "Price", with: "10.99"
    fill_in "Quantity", with: "10"
    click_button "Create Tool"

    assert page.has_content?("Screwdriver")
  end

  test "admin can edit a tool" do
    admin = User.create(username: "admin", password: "password", role: 1)
    tool = Tool.create(name: "hammer", price: 20, quantity: 30)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit edit_admin_tool_path(tool)

    fill_in "Name", with: "Screwdriver"
    fill_in "Price", with: "10.99"
    fill_in "Quantity", with: "10"
    click_button "Update Tool"

    assert page.has_content?("Screwdriver")
  end

  test "admin can delete a tool" do
    admin = User.create(username: "admin", password: "password", role: 1)
    tool = Tool.create(name: "hammer", price: 20, quantity: 30)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_tool_path(tool)

    click_link "Delete Tool"

    refute page.has_content?("hammer")
  end
end

# Authorization in ToolChest: An admin can fully CRUD categories. A regular user should not be able to create, update, or delete categories, but they should be able to see a category show page with all associated tools.
#
# User:
#
# can view index and show page for tools that belong to self
# cannot update users besides self
# cannot create see or update other users tools
# can see a category show page with all associated tools
# Admin:
#
# can create, update, read, and delete tools
# cannot update users besides self
# can CRUD categories
