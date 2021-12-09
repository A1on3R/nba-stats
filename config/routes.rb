Rails.application.routes.draw do
  root "players#index"

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
  
  

  resources :results
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
