Rails.application.routes.draw do
  
  get 'home/index'
  get 'players/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  get "/players", to:"players#index"
  get "/upload_players", to: "players#upload_players"
  post "/upload_players", to: "players#import"
  get "/teams", to:"teams#index"
  get "/dvps", to:"dvp#index"
  get "/upload_dvp", to: "dvp#upload_dvp"
  post "/upload_dvp", to: "dvp#import_dvp"
  get "/upload_salaries", to: "results#upload_salaries"
  post "/upload_salaries", to: "results#import_salaries"
  
  get "/upload_minutes", to: "results#upload_minutes"
  post "/upload_minutes", to: "results#set_minutes"
  post "/results/run_simulation", to: "results#run_simulation"
  
  

  resources :results, only: [:index, :update]
  resources :teams, only: [:index, :update]
end
