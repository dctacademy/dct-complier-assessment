require 'test_helper'

class NotificationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notification_type = notification_types(:one)
  end

  test "should get index" do
    get notification_types_url
    assert_response :success
  end

  test "should get new" do
    get new_notification_type_url
    assert_response :success
  end

  test "should create notification_type" do
    assert_difference('NotificationType.count') do
      post notification_types_url, params: { notification_type: { name: @notification_type.name } }
    end

    assert_redirected_to notification_type_url(NotificationType.last)
  end

  test "should show notification_type" do
    get notification_type_url(@notification_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_notification_type_url(@notification_type)
    assert_response :success
  end

  test "should update notification_type" do
    patch notification_type_url(@notification_type), params: { notification_type: { name: @notification_type.name } }
    assert_redirected_to notification_type_url(@notification_type)
  end

  test "should destroy notification_type" do
    assert_difference('NotificationType.count', -1) do
      delete notification_type_url(@notification_type)
    end

    assert_redirected_to notification_types_url
  end
end
