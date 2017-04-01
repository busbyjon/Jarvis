class SetLightsJob < ApplicationJob
  queue_as :default

  def perform(setting, description, start_countdown = true)
    # Do something later

    puts "Running light task for " + setting

    if (start_countdown == true) 
    	# schedule the task 
    	SetLightsJob.set(wait: 5.seconds).perform_later(setting, description, false)
    	# ok lets set a new cable message
    	message = Message.new
    	message.setMessage("Switching to " + description + " in 5 minutes")
    	return true
    else 
        
        hue = HueLights.new

        case setting
            when "morningOn"
                #Morning Lights on - Very Blue
                hue.setGroupScene('1', "k7p-YR4WpKxycig")
                hue.setGroupScene('2', "Cj-4vvWtfpiMuFS")
            when "bedtimeOn"
                hue.setGroupScene('2', "EIjdO4FCkksTpyp")
                #Upstairs Bed On - Dim slowly
                hue.setGroupScene('1',"bXo0uTWInRgbcaW")
                hue.setGroupScene('3',"-0O1XfxaCFNQCiN")
                #Living Room Off
            when "bedtimeOff"
                #All Lights Off
                hue.setGroupScene('3',"Dxv7hGOi--ySrCv")
            when "sunset"
                #Evening Mode
                 hue.setGroupScene('1', "y5ZTa0h6PdMhq2r")
            when "sunrise"
                #All Lights Off
                hue.setGroupScene('1',"bXo0uTWInRgbcaW")
                hue.setGroupScene('3',"-0O1XfxaCFNQCiN")
                hue.setGroupScene('3',"Dxv7hGOi--ySrCv")
        end

    end




  end
end
