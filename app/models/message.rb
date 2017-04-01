class Message 

	def initialize

	end

	def setMessage(message)
		Rails.cache.write("current_message", message, expires_in: 5.minutes) 
	end

	def getMessage
		Rails.cache.read("current_message")
	end


end
