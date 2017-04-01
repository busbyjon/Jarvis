#TODO - Refactor this - there must be a tidier way! - jonbusby

if ENV['RAILS_ENV'] == "development"

	Sidekiq.configure_server do |config|
  	  config.redis = { url: ENV['REDIS_URL'] }
  	  Rails.application.config.after_initialize do
	        # You code goes here
	        # commented out as this isnt needed with the scheduler
	        #GetTadoDataJob.perform_now()
	        SetSunTimesJob.perform_now()
	  end
	end

	Sidekiq.configure_client do |config|
	  config.redis = { url: ENV['REDIS_URL'] }
	end

else 

	Sidekiq.configure_server do |config|
  	  config.redis = { url: ENV['REDIS_URL'] }
  	  Rails.application.config.after_initialize do
	        # You code goes here
	        # commented out as this isnt needed with the scheduler
	        #GetTadoDataJob.perform_now()
	        SetSunTimesJob.perform_now()
	  end
	end

	Sidekiq.configure_client do |config|
	  config.redis = { url: ENV['REDIS_URL'] }
	end

end	
