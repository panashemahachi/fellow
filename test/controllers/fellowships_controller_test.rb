require 'test_helper'

class FellowshipsControllerTest < ActionController::TestCase
  setup do
    @fellowship = fellowships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fellowships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fellowship" do
    assert_difference('Fellowship.count') do
      post :create, fellowship: {  }
    end

    assert_redirected_to fellowship_path(assigns(:fellowship))
  end

  test "should show fellowship" do
    get :show, id: @fellowship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fellowship
    assert_response :success
  end

  test "should update fellowship" do
    patch :update, id: @fellowship, fellowship: {  }
    assert_redirected_to fellowship_path(assigns(:fellowship))
  end

  test "should destroy fellowship" do
    assert_difference('Fellowship.count', -1) do
      delete :destroy, id: @fellowship
    end

    assert_redirected_to fellowships_path
  end
end
