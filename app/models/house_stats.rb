class HouseStats

	def initialize
		@redis = Redis.new
		@hueclient = Hue::Client.new
		@client = Lights.new('192.168.0.5','p-P0QKxXEgg6EWJTgiRIudOB1u7YbjVnLjHfZH0O')
		#@client.register
		@client.request_bulb_list
		self.setSunTimes
	end



	def setSunTimes
		day = Date.today
		latitude = 51.6201868
		longitude = -0.7344163000000208
		sun_times = SunTimes.new
		@sunrise = sun_times.rise(day, latitude, longitude) 
		@sunset = sun_times.set(day, latitude, longitude) 

		#@hueclient.group(1).on!
		#@hueclient.group(1).scene = "Concentrate"
		#@hueclient.group(1).set_group_state({:scene => "8X49d7MF6ruhqp9"})

		http = Net::HTTP.new('192.168.0.5', 80)
		response = http.send_request('PUT', '/api/p-P0QKxXEgg6EWJTgiRIudOB1u7YbjVnLjHfZH0O/groups/1/action', '{"scene":"k7p-YR4WpKxycig"}')

		@list = @client.request_bulb_list
		
		@redis.set("sunrise", @sunrise)
		@redis.set("sunset", @sunset)
	end

	def getHue 
		return @hueclient
	end

	def changeState
		@redis.get("current_state")

		#calculate new state
		if self.isAnyoneIn?
			

	end

	def runSchedue 
		now = DateTime.now
		anyoneIn = self.IsAnyoneIn
		dayState = self.GetDayState

		case anyoneIn
			when true
				case dayState
					when "morning"
						return self.SetMorningModeIn
					when "evening"
						return self.SetNightModeIn
					when "bedtime"
						return self.SetBedtimeModeIn
					when "daytime"
						return self.SetAllOff
					else
						return self.SetAllOff
					end
			else
				return self.SetAllOff
		end

	end

	def isAnyoneIn
		return true
	end

	def GetDayState
		now = DateTime.now
		if now <= @sunrise
			return "morning"
		end

		if now >= @sunset
			return "evening"
		end

		return "daytime"
	end

	def SetMorningModeIn
		return "Set Morning Mode"
	end

	def SetNightModeIn
		return "Set Night Mode"
	end

	def SetBedtimeModeIn
		return "Set Bedtime Mode"
	end

	def SetAllOff
		return "Set All Off"
	end

end