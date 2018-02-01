require 'test_helper'

class CodePlayBacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_play_back = code_play_backs(:one)
  end

  test "should get index" do
    get code_play_backs_url
    assert_response :success
  end

  test "should get new" do
    get new_code_play_back_url
    assert_response :success
  end

  test "should create code_play_back" do
    assert_difference('CodePlayBack.count') do
      post code_play_backs_url, params: { code_play_back: { practice_id: @code_play_back.practice_id, statement: @code_play_back.statement, user_id: @code_play_back.user_id } }
    end

    assert_redirected_to code_play_back_url(CodePlayBack.last)
  end

  test "should show code_play_back" do
    get code_play_back_url(@code_play_back)
    assert_response :success
  end

  test "should get edit" do
    get edit_code_play_back_url(@code_play_back)
    assert_response :success
  end

  test "should update code_play_back" do
    patch code_play_back_url(@code_play_back), params: { code_play_back: { practice_id: @code_play_back.practice_id, statement: @code_play_back.statement, user_id: @code_play_back.user_id } }
    assert_redirected_to code_play_back_url(@code_play_back)
  end

  test "should destroy code_play_back" do
    assert_difference('CodePlayBack.count', -1) do
      delete code_play_back_url(@code_play_back)
    end

    assert_redirected_to code_play_backs_url
  end
end
