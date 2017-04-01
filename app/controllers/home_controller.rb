class HomeController < ApplicationController
	def index
		begin
			@tado = Tado.factory
			#client = Hue::Client.new
		rescue => e
			logger.error e.message
  			e.backtrace.each { |line| logger.error line }
		end
	end

	def test_stats
		@tado = Tado.factory
		ActionCable.server.broadcast 'stats',
        	indoor_temp: @tado.get_indoor_temp,
        	outdoor_temp: @tado.get_indoor_temp


		render plain: "OK"
    end

	def get_weather_image
		@tado = Tado.factory
		weather = @tado.get_home_weather
		weather = weather.downcase
		weather = Array({ :image => ActionController::Base.helpers.image_path(weather + ".jpg")})
		render json: weather
	end

	def test
		@housestats = HouseStats.new

		@state = @housestats.checkState
		@hue = @housestats.getHue
	end
end
