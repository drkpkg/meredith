require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get new_profile" do
    get :new_profile
    assert_response :success
  end

  test "should get edit_profile" do
    get :edit_profile
    assert_response :success
  end

  test "should get create_profile" do
    get :create_profile
    assert_response :success
  end

  test "should get update_profile" do
    get :update_profile
    assert_response :success
  end

  test "should get destroy_profile" do
    get :destroy_profile
    assert_response :success
  end

  test "should get block_profile" do
    get :block_profile
    assert_response :success
  end

  test "should get follow_profile" do
    get :follow_profile
    assert_response :success
  end

  test "should get suscribe_event" do
    get :suscribe_event
    assert_response :success
  end

end
