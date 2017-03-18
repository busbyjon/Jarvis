class Tado

	def self.factory (*args)
		if Rails.env.development?
			TadoDevelopment.new(*args)
		else
			TadoProduction.new(*args)
		end
	end

end

