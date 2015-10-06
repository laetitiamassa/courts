require 'test_helper'

class PreferedAreasControllerTest < ActionController::TestCase
  setup do
    @prefered_area = prefered_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prefered_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prefered_area" do
    assert_difference('PreferedArea.count') do
      post :create, prefered_area: { name: @prefered_area.name }
    end

    assert_redirected_to prefered_area_path(assigns(:prefered_area))
  end

  test "should show prefered_area" do
    get :show, id: @prefered_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prefered_area
    assert_response :success
  end

  test "should update prefered_area" do
    patch :update, id: @prefered_area, prefered_area: { name: @prefered_area.name }
    assert_redirected_to prefered_area_path(assigns(:prefered_area))
  end

  test "should destroy prefered_area" do
    assert_difference('PreferedArea.count', -1) do
      delete :destroy, id: @prefered_area
    end

    assert_redirected_to prefered_areas_path
  end
end
