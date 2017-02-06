class HomeController < ApplicationController
	def index
		@tado = Tado.new
		client = Hue::Client.new
	end
end
