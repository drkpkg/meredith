require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = User.create(email: 'user@email.com', password: 'some_password_1234', terms: true)
  end

  test "should get dashboard" do
    get :dashboard, id: @user.id
    assert_response :redirect
  end

  test "should get profile" do
    get :profile, id: @user.id
    assert_response :redirect
  end

  test "should get new profile" do
    get :new_profile
    assert_response :success
  end

  test "should get profile info" do
    get :profile, id: @user.id
    assert_response :redirect
  end

  test "should edit profile" do
    get :update_profile, id: @user.id
    assert_response :redirect
  end

  test "should create profile" do
    email = 'user@mail.com'
    terms = true
    user_type = 'photographer'
    password = 'some_password_1234'
    password_confirmation = 'some_password_1234'
    post :create_profile, user:{email: email, terms: terms, user_type: user_type, password: password, password_confirmation: password_confirmation}, format: 'js'
    assert_response :success, "Should be success"
  end

  test "should update profile" do
    patch :update_profile, id: @user.id, user:{name:"Cosme", lastname:"Fulanito", alias:"Cosmetin", avatar:"", phones_list:[12345678, 3402212], social_networks_list:{}, sex:"h", address:"Address", country:"BO" }
    assert_response :redirect
  end

  test "should destroy profile" do
    delete :destroy_profile, id: @user.id
    assert_response :redirect
  end

end
