class GetTadoDataJob < ApplicationJob
  queue_as :default
  RUN_EVERY = 10.seconds


  def perform(*args)

    @tado = Tado.factory
	
    message = Message.new
    current_message = message.getMessage

    was_anyone_home = Rails.cache.read('is_anyone_home')

    current_home_status = false

    # Devices - TODO - refactor this
    devices = ["Jon's Phone", "Sally's Phone"]

    device_status = Hash.new

    devices.each do |device|
      status = @tado.get_device_status_bool(device)
      device_status.store(device,status)
      if (status == true) 
        current_home_status = true
      end
    end

    puts "JARVIS [DEBUG] : Current status is : " + current_home_status.to_s
    puts "JARVIS [DEBUG] : Previous status is : " + was_anyone_home.to_s

    # Ok lets do the device status check
    # There's probably some clever short code way of solving for this
    # but I cant figure that out - so its just a simple set of if statements

    if (current_home_status == false && was_anyone_home == true) 
      puts "JARVIS : everyone has gone out - turn off the lights"
      # turn off all the lights
      SetLightsJob.perform_later("allOff", "All Lights Off", false)
    elsif (current_home_status == true && was_anyone_home == false)
      puts "JARVIS : someone's come home - turn on the lights"
      # Get the last light status and turn them on.
      light_state = Rails.cache.read("light_state_setting")
      light_description = Rails.cache.read("light_state_description")

      puts "JARVIS : setting lights back to " + light_state + " - " + light_description

      SetLightsJob.perform_later(light_state, light_description, false)
      # Set message to welcome home
      message = Message.new
      message.setMessage("Welcome home, lights set back to " + light_description)
    end
      
    puts "JARVIS : Writing cache key for is_anyone_home to " + current_home_status.to_s
    Rails.cache.write('is_anyone_home', current_home_status)

    # Weather

    weather = @tado.get_home_weather
    weather = weather.downcase
    weather_image = ActionController::Base.helpers.image_path(weather + ".jpg")

    # Re-read from cache just incase
    current_light_mode = Rails.cache.read("light_state_description")

  	ActionCable.server.broadcast 'stats',
          indoor_temp: @tado.get_indoor_temp,
          outdoor_temp: @tado.get_outdoor_temp,
          weather: @tado.get_home_weather,
          weather_image: weather_image,
          current_message: current_message,
          current_light_mode: current_light_mode,
          device_status: device_status

    #self.class.set(wait: RUN_EVERY).perform_later

  end
end
