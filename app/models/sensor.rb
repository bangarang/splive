class Sensor < ActiveRecord::Base
	has_many :values
	accepts_nested_attributes_for :values, allow_destroy: true
	def value 
		7
	end
end
