class HomeController < ApplicationController
	def index
		begin
			@tado = Tado.new
			client = Hue::Client.new
		rescue
			client = false
			@tado = false
		end
	end
end
