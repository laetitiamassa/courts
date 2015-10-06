require 'test_helper'

class LocoEvaluationsControllerTest < ActionController::TestCase
  setup do
    @loco_evaluation = loco_evaluations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loco_evaluations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loco_evaluation" do
    assert_difference('LocoEvaluation.count') do
      post :create, loco_evaluation: { comment: @loco_evaluation.comment, court_id: @loco_evaluation.court_id, evaluation: @loco_evaluation.evaluation, user_id: @loco_evaluation.user_id }
    end

    assert_redirected_to loco_evaluation_path(assigns(:loco_evaluation))
  end

  test "should show loco_evaluation" do
    get :show, id: @loco_evaluation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loco_evaluation
    assert_response :success
  end

  test "should update loco_evaluation" do
    patch :update, id: @loco_evaluation, loco_evaluation: { comment: @loco_evaluation.comment, court_id: @loco_evaluation.court_id, evaluation: @loco_evaluation.evaluation, user_id: @loco_evaluation.user_id }
    assert_redirected_to loco_evaluation_path(assigns(:loco_evaluation))
  end

  test "should destroy loco_evaluation" do
    assert_difference('LocoEvaluation.count', -1) do
      delete :destroy, id: @loco_evaluation
    end

    assert_redirected_to loco_evaluations_path
  end
end
