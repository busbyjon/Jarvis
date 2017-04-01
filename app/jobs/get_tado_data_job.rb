class GetTadoDataJob < ApplicationJob
  queue_as :default
  RUN_EVERY = 10.seconds


  def perform(*args)
	
    message = Message.new
    current_message = message.getMessage
    @tado = Tado.factory
  	ActionCable.server.broadcast 'stats',
          indoor_temp: @tado.get_indoor_temp,
          outdoor_temp: @tado.get_outdoor_temp,
          weather: @tado.get_home_weather,
          current_message: current_message

    #self.class.set(wait: RUN_EVERY).perform_later

  end
end
