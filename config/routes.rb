Rails.application.routes.draw do
  resources :weather_grid
  root to: 'home#index'
end
