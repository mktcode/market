require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @user = users(:one)
  end

  test "should get index" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    get products_url
    assert_response :success
  end

  test "should get new" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_difference("Product.count") do
      post products_url, params: { product: { body: @product.body, title: @product.title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    patch product_url(@product), params: { product: { body: @product.body, title: @product.title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
