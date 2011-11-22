Hallofcatan::Application.routes.draw do
  root :to => 'home#index'
  
  resources :players
  resources :games
  resources :locations
end
