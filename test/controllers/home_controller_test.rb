require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get home_top_url
    assert_response :success
  end

  test "should get games" do
    get home_games_url
    assert_response :success
  end

  test "should get apps" do
    get home_apps_url
    assert_response :success
  end

  test "should get terms" do
    get home_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get home_privacy_url
    assert_response :success
  end

  test "should get contact_form" do
    get home_contact_form_url
    assert_response :success
  end

  test "should get contact_done" do
    get home_contact_done_url
    assert_response :success
  end

end
