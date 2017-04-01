class HueLights
	
	def initialise

	end

	def setGroupScene(group, scene)
		puts "Setting group : " + group + " to scene " + scene
		http = Net::HTTP.new('192.168.0.5', 80)
		response = http.send_request('PUT', '/api/p-P0QKxXEgg6EWJTgiRIudOB1u7YbjVnLjHfZH0O/groups/' + group + '/action', '{"scene":"' + scene + '"}')

	end

	def AllLightsOff


	end


end