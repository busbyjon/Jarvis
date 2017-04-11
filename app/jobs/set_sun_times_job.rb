class SetSunTimesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # time to find the sunset time and set it 
    puts "Setting Times Time"

	day = Date.today
	latitude = 51.6201868
	longitude = -0.7344163000000208
	sun_times = SunTimes.new
	sunrise = sun_times.rise(day, latitude, longitude) 
	sunset = sun_times.set(day, latitude, longitude) 

	now = DateTime.now

	if (now < sunrise) 
		SetLightsJob.set(wait_until: sunrise).perform_later("sunrise", "Sunrise")
	end

	if (now < sunset)
		SetLightsJob.set(wait_until: sunset - 25.minutes).perform_later("sunset", "Sunset")
	end
	# Not using Sidekiq scheduler here - as actually - its tidier to just use sidekiq

	#Sidekiq.set_schedule('sunrise', { 'at' => sunrise.strftime('%Y/%m/%d %T'), 'class' => 'SetLightsJob', 'args' => 'sunrise' })
	#Sidekiq.set_schedule('sunset', { 'at' => sunset.strftime('%Y/%m/%d %T'), 'class' => 'SetLightsJob', 'args' => 'sunset' })

	#Sidekiq::Scheduler.reload_schedule!

  end
end
