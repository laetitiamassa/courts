require 'test_helper'

class PrivateDocumentationsControllerTest < ActionController::TestCase
  setup do
    @private_documentation = private_documentations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:private_documentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create private_documentation" do
    assert_difference('PrivateDocumentation.count') do
      post :create, private_documentation: { conversation_id: @private_documentation.conversation_id, name: @private_documentation.name, user_id: @private_documentation.user_id }
    end

    assert_redirected_to private_documentation_path(assigns(:private_documentation))
  end

  test "should show private_documentation" do
    get :show, id: @private_documentation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @private_documentation
    assert_response :success
  end

  test "should update private_documentation" do
    patch :update, id: @private_documentation, private_documentation: { conversation_id: @private_documentation.conversation_id, name: @private_documentation.name, user_id: @private_documentation.user_id }
    assert_redirected_to private_documentation_path(assigns(:private_documentation))
  end

  test "should destroy private_documentation" do
    assert_difference('PrivateDocumentation.count', -1) do
      delete :destroy, id: @private_documentation
    end

    assert_redirected_to private_documentations_path
  end
end
