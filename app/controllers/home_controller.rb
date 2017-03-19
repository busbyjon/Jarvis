class HomeController < ApplicationController
	def index
		begin
			@tado = Tado.factory
			if Rails.env.development? 
				#client = Hue::Client.new
				#client = "test"
			else
				#client = Hue::Client.new
			end
		rescue => e
			logger.error e.message
  			e.backtrace.each { |line| logger.error line }
			client = false
			@tado = false
		end
	end

	def get_weather_image
		@tado = Tado.factory
		weather = @tado.get_home_weather
		weather = Array({ :image => ActionController::Base.helpers.image_path(weather + ".jpg")})
		render json: weather
	end

	def test
		@report = ARPScan('--localnet')
	end
end
