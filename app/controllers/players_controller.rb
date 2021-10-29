class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def upload_players
  end



  def import
    player_obj = Player.new
    player_obj.file = params[:file]
    player_obj.import()
    redirect_to action: "index"
  
  end
  


 
 

end
