require 'test_helper'

class InfiniteBlocksControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get infinite_blocks_home_url
    assert_response :success
  end

  test "should get result" do
    get infinite_blocks_result_url
    assert_response :success
  end

  test "should get records" do
    get infinite_blocks_records_url
    assert_response :success
  end

  test "should get tweet_done" do
    get infinite_blocks_tweet_done_url
    assert_response :success
  end

end
