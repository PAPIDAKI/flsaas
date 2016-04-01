Rails.application.routes.draw do
   resources :weather_grid
  root to: 'home#index'

   devise_for :users

end
