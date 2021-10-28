Rails.application.routes.draw do
  root "players#index"

  get "/players", to:"players#index"
  get "/upload_players", to: "players#upload_players"
  post "/upload_players", to: "players#import"
  get "/teams", to:"teams#index"
  get "/dvps", to:"dvp#index"
  get "/upload_dvp", to: "dvp#upload_dvp"
  post "/upload_dvp", to: "dvp#import_dvp"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
