require 'test_helper'

class ValuesControllerTest < ActionController::TestCase
  setup do
    @value = values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:values)
  end

  test "should create value" do
    assert_difference('Value.count') do
      post :create, value: { decibel: @value.decibel, sensor_id: @value.sensor_id }
    end

    assert_response 201
  end

  test "should show value" do
    get :show, id: @value
    assert_response :success
  end

  test "should update value" do
    put :update, id: @value, value: { decibel: @value.decibel, sensor_id: @value.sensor_id }
    assert_response 204
  end

  test "should destroy value" do
    assert_difference('Value.count', -1) do
      delete :destroy, id: @value
    end

    assert_response 204
  end
end
