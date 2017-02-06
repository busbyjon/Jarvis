namespace :getdata do
  desc "TODO"
  task tado: :environment do
  	Rails.cache.read("tado_token")
  	GetTadoDataJob.perform_now
  end

  desc "TODO"
  task hue: :environment do
  end

  desc "TODO"
  task network: :environment do
  end

end
