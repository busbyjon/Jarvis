class HomeController < ApplicationController
	def index
		begin
			@tado = Tado.new
			client = Hue::Client.new
		rescue => e
			logger.error e.message
  			e.backtrace.each { |line| logger.error line }
			client = false
			@tado = false
		end
	end

	def test
		@report = ARPScan('--localnet')
	end
end
