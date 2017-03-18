class TadoDevelopment < Tado

	def initialize
		puts "In Development Mode"
	end

	def get_token

	end


	def get_home_details
		return "0001"
	end

	def get_indoor_temp 
		return "19.86"
	end

	def get_device_status(device) 
		return "home"
	end

	def get_home_mode 
		return "home"
	end

	def get_home_weather
		return "rain"
	end

	def get_outdoor_temp 
		return "6.00"
	end

end
