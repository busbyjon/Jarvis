class GetTadoDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
  	tado = Tado.new
  	puts tado.get_outdoor_temp
  end
end
