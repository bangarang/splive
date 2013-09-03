class SensorsController < ApplicationController
  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all

    render json: @sensors
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    @sensor = Sensor.find(params[:id])

    render json: @sensor
  end

  # def values
  #   @sensor = Sensor.find(params[:id])
  #   @values = @sensor.values
  #   render json: @values
  # end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(params[:sensor])

    if @sensor.save
      render json: @sensor, status: :created, location: @sensor
    else
      render json: @sensor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    @sensor = Sensor.find(params[:id])

    if @sensor.update(params[:sensor])
      head :no_content
    else
      render json: @sensor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor = Sensor.find(params[:id])
    @sensor.destroy

    head :no_content
  end
end
