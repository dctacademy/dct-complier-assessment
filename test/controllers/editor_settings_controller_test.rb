require 'test_helper'

class EditorSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor_setting = editor_settings(:one)
  end

  test "should get index" do
    get editor_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_editor_setting_url
    assert_response :success
  end

  test "should create editor_setting" do
    assert_difference('EditorSetting.count') do
      post editor_settings_url, params: { editor_setting: { theme_css: @editor_setting.theme_css, theme_name: @editor_setting.theme_name, user_id: @editor_setting.user_id } }
    end

    assert_redirected_to editor_setting_url(EditorSetting.last)
  end

  test "should show editor_setting" do
    get editor_setting_url(@editor_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_editor_setting_url(@editor_setting)
    assert_response :success
  end

  test "should update editor_setting" do
    patch editor_setting_url(@editor_setting), params: { editor_setting: { theme_css: @editor_setting.theme_css, theme_name: @editor_setting.theme_name, user_id: @editor_setting.user_id } }
    assert_redirected_to editor_setting_url(@editor_setting)
  end

  test "should destroy editor_setting" do
    assert_difference('EditorSetting.count', -1) do
      delete editor_setting_url(@editor_setting)
    end

    assert_redirected_to editor_settings_url
  end
end
