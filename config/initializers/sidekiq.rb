Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:32768/12' }

  Rails.application.config.after_initialize do
        # You code goes here
        GetTadoDataJob.perform_now()
  end
end
