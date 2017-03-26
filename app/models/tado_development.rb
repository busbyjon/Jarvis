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
		return rand(10.01...23.55).round(1)
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
		return rand(0.01...15.55).round(1)
	end

end
