class UpdateCountdownJob < ApplicationJob
  queue_as :default

  def perform(description, minutes)
    # Do something later

    puts "JARVIS : Reducing countdown for " + description

    message = Message.new
    message.setMessage("Switching to " + description + " in 5 minutes")

    minutesToSet = minutes - 1
    if (minutesToSet > 0) 
        UpdateCountdownJob.set(wait: 1.minute).perform_later(description, minutesToSet)
    end


  end
end
