class HomeStatus 

	def initialize

		@tado = Tado.factory
		day = Date.today
		latitude = 51.6201868
		longitude = -0.7344163000000208
		sun_times = SunTimes.new
		@sunrise = sun_times.rise(day, latitude, longitude) 
		@sunset = sun_times.set(day, latitude, longitude) 

	end

	def is_it_dark

		now = DateTime.now

		if (now < @sunrise) 
			return true
		end

		if (now > @sunset)
			return true
		end

		return false

	end	


	def is_anyone_home

		devices = ["Jon's Phone", "Sally's Phone"]

		devices.each do |device|
			if (@tado.get_device_status_bool(device) == true)
				return true
			end
		end

		return false

	end


end