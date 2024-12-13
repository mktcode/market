require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
    @user = users(:one)
  end

  test "visiting the index" do
    visit products_url
    login_as @user
    assert_selector "h1", text: "My Shop"
  end

  test "should create product" do
    visit new_product_url
    login_as @user

    fill_in_trix "product_body", with: "Work for us!!!"
    fill_in "Title", with: @product.title
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    login_as @user
    click_on "Edit this product", match: :first

    fill_in_trix "product_body", with: "Work for us!!!"
    fill_in "Title", with: @product.title
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    login_as @user
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
