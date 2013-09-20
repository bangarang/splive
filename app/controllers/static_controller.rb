class StaticController < ActionController::Base
	def index
	end
	def sensor
	    @sensor = Sensor.find(params[:id])
	    @values = @sensor.values

	    s = []
	    for v in @values 
	      s.push( { :id => v.id, :decibel => v.decibel } )
	    end
	    @v = s


	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: { :name => @sensor.name, :value => @sensor.value, :id => @sensor.id} }
    end
  end
end 