module WeatherHelper

	def weather_icon(constant)
		return constant.downcase.gsub("_", "-").gsub("foggy","fog")
	end
end
