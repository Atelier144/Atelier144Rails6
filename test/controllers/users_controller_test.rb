require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get profile" do
    get users_profile_url
    assert_response :success
  end

  test "should get login_form" do
    get users_login_form_url
    assert_response :success
  end

  test "should get signup_form" do
    get users_signup_form_url
    assert_response :success
  end

  test "should get profile_form" do
    get users_profile_form_url
    assert_response :success
  end

  test "should get profile_done" do
    get users_profile_done_url
    assert_response :success
  end

  test "should get email_form" do
    get users_email_form_url
    assert_response :success
  end

  test "should get email_done" do
    get users_email_done_url
    assert_response :success
  end

  test "should get email_create_done" do
    get users_email_create_done_url
    assert_response :success
  end

  test "should get password_form" do
    get users_password_form_url
    assert_response :success
  end

  test "should get password_done" do
    get users_password_done_url
    assert_response :success
  end

  test "should get sns_form" do
    get users_sns_form_url
    assert_response :success
  end

  test "should get sns_done" do
    get users_sns_done_url
    assert_response :success
  end

  test "should get records_form" do
    get users_records_form_url
    assert_response :success
  end

  test "should get records_done" do
    get users_records_done_url
    assert_response :success
  end

  test "should get forgot_password_form" do
    get users_forgot_password_form_url
    assert_response :success
  end

  test "should get forgot_password_done" do
    get users_forgot_password_done_url
    assert_response :success
  end

  test "should get reset_password_form" do
    get users_reset_password_form_url
    assert_response :success
  end

  test "should get reset_password_done" do
    get users_reset_password_done_url
    assert_response :success
  end

  test "should get twitter" do
    get users_twitter_url
    assert_response :success
  end

end
