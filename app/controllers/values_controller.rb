class ValuesController < ApplicationController
  # GET /values
  # GET /values.json
  def index
    @sensor = Sensor.find(params[:id])
    @values = @sensor.values
    render json: @values
  end

  # GET /values/1
  # GET /values/1.json
  def show
    @value = Value.find(params[:id])

    render json: @value
  end

  # POST /values
  # POST /values.json
  def create
    @value = Value.new(params[:value])

    if @value.save
      # render json: @value, status: :created, location: @value
      redirect_to root_path
    else
      render json: @value.errors, status: :unprocessable_entity
    end
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
