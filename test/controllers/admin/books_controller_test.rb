require "test_helper"

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_books_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_books_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_books_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_books_edit_url
    assert_response :success
  end
end
