require 'test_helper'

class DominusLitisEvaluationsControllerTest < ActionController::TestCase
  setup do
    @dominus_litis_evaluation = dominus_litis_evaluations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dominus_litis_evaluations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dominus_litis_evaluation" do
    assert_difference('DominusLitisEvaluation.count') do
      post :create, dominus_litis_evaluation: { comment: @dominus_litis_evaluation.comment, court_id: @dominus_litis_evaluation.court_id, evaluation: @dominus_litis_evaluation.evaluation, user_id: @dominus_litis_evaluation.user_id }
    end

    assert_redirected_to dominus_litis_evaluation_path(assigns(:dominus_litis_evaluation))
  end

  test "should show dominus_litis_evaluation" do
    get :show, id: @dominus_litis_evaluation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dominus_litis_evaluation
    assert_response :success
  end

  test "should update dominus_litis_evaluation" do
    patch :update, id: @dominus_litis_evaluation, dominus_litis_evaluation: { comment: @dominus_litis_evaluation.comment, court_id: @dominus_litis_evaluation.court_id, evaluation: @dominus_litis_evaluation.evaluation, user_id: @dominus_litis_evaluation.user_id }
    assert_redirected_to dominus_litis_evaluation_path(assigns(:dominus_litis_evaluation))
  end

  test "should destroy dominus_litis_evaluation" do
    assert_difference('DominusLitisEvaluation.count', -1) do
      delete :destroy, id: @dominus_litis_evaluation
    end

    assert_redirected_to dominus_litis_evaluations_path
  end
end
