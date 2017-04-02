class TadoProduction < Tado

	def initialize
		@conn = Faraday.new(:url => 'https://my.tado.com') do |faraday|
		  faraday.request  :url_encoded             # form-encode POST params
		  faraday.response :logger                  # log requests to STDOUT
		  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end
		@conn.authorization :Bearer, self.get_token
	end

	def get_token
		Rails.cache.fetch("tado_token", expires_in: 10.minutes) do
			response = @conn.post '/oauth/token', { :client_id => 'tado-webapp', :grant_type => 'password', :password => ENV["TADO_PASSWORD"], :username =>ENV["TADO_USERNAME"], :scope => 'home.user' }
			token_response = JSON.parse response.body
			token_response['access_token']
		end
	end


	def get_home_details
		Rails.cache.fetch("tado_house_details", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url '/api/v2/me'
			  # req.headers['Authorization'] = 'Bearer ' + self.get_token
			end
			puts JSON.parse response.body
			house_response = (JSON.parse response.body)['homes'][0]["id"]
		end
	end

	def get_indoor_temp 
		@home = self.get_home_details
		url =  '/api/v2/homes/' + @home.to_s  + '/zones/1/state'
		Rails.cache.fetch("tado_indoor_temp", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url url
			end
			temp_response = (JSON.parse response.body)["sensorDataPoints"]["insideTemperature"]["celsius"]
		end
	end

	def get_device_status(device) 
		Rails.cache.fetch("tado_device_status_#{device}", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url '/api/v2/me'
			end
			house_response = (JSON.parse response.body)["mobileDevices"]
			house_response.each do |mobileDevices| 
				if mobileDevices["name"] == device
					output = mobileDevices['location']['atHome']
					if output == true
						return "home"
					else 
						return "car"
					end
				end
			end
			return "find"
		end
	end

	def get_home_mode 
		@home = self.get_home_details
		url =  '/api/v2/homes/' + @home.to_s  + '/zones/1/state'
		Rails.cache.fetch("tado_indoor_temp", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url url
			end
			temp_response = (JSON.parse response.body)["tadoMode"]
		end
	end

	def get_home_weather
		@home = self.get_home_details
		url =  '/api/v2/homes/' + @home.to_s  + '/weather'
		Rails.cache.fetch("tado_weather", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url url
			end
			weather_response = (JSON.parse response.body)["weatherState"]["value"]
			weather_response.downcase.gsub("_", "-").gsub("foggy","fog").gsub("sun","day-sunny").gsub("cloudy-mostly", "cloudy").gsub("scattered-rain", "rain-mix").gsub("drizzle", "sprinkle").gsub("cloudy-partly", "cloud")
		end
	end

	def get_outdoor_temp 
		@home = self.get_home_details
		url =  '/api/v2/homes/' + @home.to_s  + '/weather'
		Rails.cache.fetch("tado_outdoor_temp", expires_in: 1.minute) do
			response = @conn.get do |req|
			  req.url url
			end
			temp_response = (JSON.parse response.body)["outsideTemperature"]["celsius"]
		end
	end

end
