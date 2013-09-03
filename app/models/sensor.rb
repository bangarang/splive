class Sensor < ActiveRecord::Base
	has_many :values
	accepts_nested_attributes_for :values, allow_destroy: true
	def value 
		unless self.values.blank?
			return self.values.last.decibel
		else
			return 0
		end
	end
end
