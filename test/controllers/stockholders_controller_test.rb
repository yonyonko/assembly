require 'test_helper'

class StockholdersControllerTest < ActionController::TestCase
  setup do
    @stockholder = stockholders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stockholders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stockholder" do
    assert_difference('Stockholder.count') do
      post :create, stockholder: { email: @stockholder.email, name: @stockholder.name }
    end

    assert_redirected_to stockholder_path(assigns(:stockholder))
  end

  test "should show stockholder" do
    get :show, id: @stockholder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stockholder
    assert_response :success
  end

  test "should update stockholder" do
    patch :update, id: @stockholder, stockholder: { email: @stockholder.email, name: @stockholder.name }
    assert_redirected_to stockholder_path(assigns(:stockholder))
  end

  test "should destroy stockholder" do
    assert_difference('Stockholder.count', -1) do
      delete :destroy, id: @stockholder
    end

    assert_redirected_to stockholders_path
  end
end
