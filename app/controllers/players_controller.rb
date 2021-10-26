class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def upload_players
  end



  def import
    require 'csv'
    myfile = params[:file]
    player_row_array = CSV.read(myfile.path)

    #Clear the player db so i Overwrite instead of extend
    Player.delete_all

    CSV.foreach(myfile.path, headers: true) do |row|
      Player.create!(row.to_hash)
    end

      redirect_to action: "index"
    end
  

 

end
