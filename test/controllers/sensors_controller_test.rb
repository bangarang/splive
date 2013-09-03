require 'test_helper'

class SensorsControllerTest < ActionController::TestCase
  setup do
    @sensor = sensors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sensors)
  end

  test "should create sensor" do
    assert_difference('Sensor.count') do
      post :create, sensor: { name: @sensor.name }
    end

    assert_response 201
  end

  test "should show sensor" do
    get :show, id: @sensor
    assert_response :success
  end

  test "should update sensor" do
    put :update, id: @sensor, sensor: { name: @sensor.name }
    assert_response 204
  end

  test "should destroy sensor" do
    assert_difference('Sensor.count', -1) do
      delete :destroy, id: @sensor
    end

    assert_response 204
  end
end
