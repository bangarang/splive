require 'streamer/sse'

class ValuesController < ApplicationController
  include ActionController::Live
  # GET /values
  # GET /values.json
  def index
    @sensor = Sensor.find(params[:id])
    @values = @sensor.values
    # render json: @values

    s = []
    for v in @values 
      s.push( { :id => v.id, :decibel => v.decibel } )
    end
    render json: s

  end

  # GET /values/1
  # GET /values/1.json
  def show
    @value = Value.find(params[:id])

    render json: { :decibel => @value.decibel, :id => @value.id }
  end

  # POST /values
  # POST /values.json
  # def create
  #   @value = Value.new(params[:value])

  #   @sensor = Sensor.find(params[:id])
  #   @value.sensor_id ||= @sensor.id



  #   if @value.save
  #     # render json: @value, status: :created, location: @value
  #     $redis.publish('sensors.update', { :name => @sensor.name, :value => @sensor.value, :id => @sensor.id}.to_json)
  #   else
  #     render json: @value.errors, status: :unprocessable_entity
  #   end
  # end
  def create
    response.headers['Content-Type'] = 'text/javascript'
    @value = Value.new(params[:value])
    @sensor = Sensor.find(params[:id])
    @value.sensor_id ||= @sensor.id
    @value.save
    $redis.publish('sensors.update', { :value => @value.decibel, :id => @sensor.id}.to_json)
    render nothing: true
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Streamer::SSE.new(response.stream)
    redis = Redis.new
    redis.subscribe('sensors.update') do |on|
      on.message do |event, data|
        sse.write(data, event: 'sensors.update')
      end
    end
    render nothing: true
  rescue IOError
    # Client disconnected
  ensure
    redis.quit
    sse.close
  end

  # PATCH/PUT /values/1
  # PATCH/PUT /values/1.json
  def update
    @value = Value.find(params[:id])

    if @value.update(params[:value])
      head :no_content
    else
      render json: @value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /values/1
  # DELETE /values/1.json
  def destroy
    @value = Value.find(params[:id])
    @value.destroy

    head :no_content
  end
end
