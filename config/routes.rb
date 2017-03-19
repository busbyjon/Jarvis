Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

mount ActionCable.server => '/cable'


get 'test', to: 'home#test'
get 'weather_image', to: 'home#get_weather_image'

root 'home#index'

end
