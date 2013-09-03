require 'streamer/sse'

class SensorsController < ApplicationController
  include ActionController::Live
  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all

    s = []
    for sensor in @sensors 
      s.push( {:name =>  sensor.name, :value => sensor.value, :id => sensor.id} )
    end
    render json: s
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    @sensor = Sensor.find(params[:id])

    render json: { :name => @sensor.name, :value => @sensor.value, :id => @sensor.id}
  end

  # def values
  #   @sensor = Sensor.find(params[:id])
  #   @values = @sensor.values
  #   render json: @values
  # end

  # POST /sensors
  # POST /sensors.json
  # def create
  #   @sensor = Sensor.new(params[:sensor])

  #   if @sensor.save
  #     render json: @sensor, status: :created, location: @sensor
  #   else
  #     render json: @sensor.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    response.headers['Content-Type'] = 'text/javascript'
    @sensor = Sensor.new(params[:sensor])
    @sensor.save
    $redis.publish('sensors.new', { :name => @sensor.name, :value => @sensor.value, :id => @sensor.id}.to_json)
    render nothing: true
  end



  def events
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Streamer::SSE.new(response.stream)
    redis = Redis.new
    redis.subscribe('sensors.new') do |on|
      on.message do |event, data|
        sse.write(data, event: 'sensors.new')
      end
    end
    render nothing: true
  rescue IOError
    # Client disconnected
  ensure
    redis.quit
    sse.close
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    @sensor = Sensor.find(params[:id])

    if @sensor.update(params[:sensor])
      head :no_content
      $redis.publish('sensors.update', { :name => @sensor.name, :value => @sensor.value, :id => @sensor.id}.to_json)
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
  
  private 
    def sensor_params
      params.require(:sensor).permit(:name, :value)
    end
end
