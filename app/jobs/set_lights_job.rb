class SetLightsJob < ApplicationJob
  queue_as :default

  def perform(setting, description, start_countdown = true)
    # Do something later

    puts "JARVIS : Running light task for " + setting

    if (start_countdown == true) 
    	# schedule the task 
    	SetLightsJob.set(wait: 5.minutes).perform_later(setting, description, false)
    	# ok lets set a new cable message
    	message = Message.new
    	message.setMessage("Switching to " + description + " in 5 minutes")
    	return true
    else 

        hue = HueLights.new

        if (setting == "allOff") 
            #Override all others and turn lights off
            puts "JARVIS : Turning off all lights"
            hue.setGroupState('0',"false")
            return true
        end

        #lets save the current state - so we can refer to it if no one is home
        Rails.cache.write("light_state_setting", setting)
        Rails.cache.write("light_state_description", description)
        
        # Only run this when someone is home!
        # TODO : Refactor this code
        puts "JARVIS : Checking if anyone is home"
        home = HomeStatus.new
        if home.is_anyone_home == false 
            puts "JARVIS : No one is home - do not trigger lights"
            return false
        end

        # Check if its dail light (this happens when sunrise is before morning lights 
        # during the weeking)
        if home.is_it_dark == false
            puts "JARVIS : its not dark, dont trigger lights"
            # Lets also set the current day mode
            Rails.cache.write("light_state_setting", "daylight")
            Rails.cache.write("light_state_description", "Daylight")
            return false
        end
        

        case setting
            when "morningOn"
                #Morning Lights on - Very Blue
                hue.setGroupScene('1', "MzIKAB1TjNIPkrM")
                hue.setGroupScene('3', "0b0wGqWiWPy1FUQ")
                hue.setGroupScene('2', "tijZkSob7GSzaKW")
            when "bedtimeOn"
                hue.setGroupState('1',"false")
                hue.setGroupState('3',"false")
                hue.setGroupScene('2', "h-m9VVzMzkCPGzA")
                #Living Room Off
            when "bedtimeOff"
                #All Lights Off
                hue.setGroupState('0',"false")
            when "sunset"
                #Evening Mode
                 hue.setGroupScene('1', "rIg438uSIfL57JI")
                 hue.setGroupScene('3', "lJOfC6ZAtF4AmGE")
                 hue.setGroupScene('2', "NUzJbNcROx-C4aA")
            when "sunrise"
                #All Lights Off
                hue.setGroupState('0',"false")
            when "dusk"
                hue.setGroupScene('1', "ULlHTEF18cxmM6C")
                hue.setGroupScene('3', "Jzv4z4XumIVMDOK")
        end

    end




  end
end
