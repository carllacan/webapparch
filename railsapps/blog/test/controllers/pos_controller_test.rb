require 'test_helper'

class PosControllerTest < ActionController::TestCase
  setup do
    @po = pos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create po" do
    assert_difference('Po.count') do
      post :create, po: {  }
    end

    assert_redirected_to po_path(assigns(:po))
  end

  test "should show po" do
    get :show, id: @po
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @po
    assert_response :success
  end

  test "should update po" do
    patch :update, id: @po, po: {  }
    assert_redirected_to po_path(assigns(:po))
  end

  test "should destroy po" do
    assert_difference('Po.count', -1) do
      delete :destroy, id: @po
    end

    assert_redirected_to pos_path
  end
end
