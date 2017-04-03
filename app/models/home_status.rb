class HomeStatus 

	def initialize

		@tado = Tado.factory


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