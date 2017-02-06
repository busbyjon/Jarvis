module WeatherHelper

	def weather_icon(constant)
		return constant.downcase.gsub("_", "-")
	end
end
