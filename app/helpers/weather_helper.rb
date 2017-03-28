module WeatherHelper

	def weather_icon(constant)
		return constant.downcase.gsub("_", "-").gsub("foggy","fog").gsub("sun","day-sunny").gsub("cloudy-mostly", "cloudy")
	end
end
