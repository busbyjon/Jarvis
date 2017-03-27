Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }

  Rails.application.config.after_initialize do
        # You code goes here
        GetTadoDataJob.perform_now()
  end
end
