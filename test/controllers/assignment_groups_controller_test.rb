require 'test_helper'

class AssignmentGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment_group = assignment_groups(:one)
  end

  test "should get index" do
    get assignment_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_assignment_group_url
    assert_response :success
  end

  test "should create assignment_group" do
    assert_difference('AssignmentGroup.count') do
      post assignment_groups_url, params: { assignment_group: { batch_id: @assignment_group.batch_id, title: @assignment_group.title } }
    end

    assert_redirected_to assignment_group_url(AssignmentGroup.last)
  end

  test "should show assignment_group" do
    get assignment_group_url(@assignment_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_assignment_group_url(@assignment_group)
    assert_response :success
  end

  test "should update assignment_group" do
    patch assignment_group_url(@assignment_group), params: { assignment_group: { batch_id: @assignment_group.batch_id, title: @assignment_group.title } }
    assert_redirected_to assignment_group_url(@assignment_group)
  end

  test "should destroy assignment_group" do
    assert_difference('AssignmentGroup.count', -1) do
      delete assignment_group_url(@assignment_group)
    end

    assert_redirected_to assignment_groups_url
  end
end
