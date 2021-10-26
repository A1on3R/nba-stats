Rails.application.routes.draw do
  root "players#index"

  get "/players", to:"players#index"
  get "/upload_players", to: "players#upload_players"
  post "/upload_players", to: "players#import"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
