class Message 

	def initialize

	end

	def setMessage(message)
		Rails.cache.write("current_message", message, expires_in: 5.minutes)
		# lets trigger the get tado data task, as this will push the message to the dashboard
		# TODO : refactor this job
		#GetTadoDataJob.perform_now
	end

	def getMessage
		Rails.cache.read("current_message")
	end


end
