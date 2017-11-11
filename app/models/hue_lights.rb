class HueLights

	def self.factory (*args)
    puts "Setting up Hue"
		if Rails.env.development?
			HueLightsDevelopment.new(*args)
		else
			HueLightsProduction.new(*args)
		end
	end

end
