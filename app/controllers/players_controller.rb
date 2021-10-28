class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def upload_players
  end



  def import
    require 'csv'
    myfile = params[:file]
    

    #Clear the player db so i Overwrite instead of extend
    Player.delete_all

    CSV.foreach(myfile.path, headers: true) do |row|
      Player.create!(row.to_hash)
    end
    create_teams

      redirect_to action: "index"
    end
  


    def create_teams
      teamnames = ["ATL","NOP","MIA","POR","LAL","OKC","CHA","ORL","WAS","BOS",
          "MIN","MIL","IND","BKN","TOR","PHX","SAC","CLE","LAC","MEM",
          "PHI","CHI","DEN","SAS","HOU","DAL","UTA","NYK"]

      Team.delete_all

      teamnames.each do |abrv|
          x = Team.new
          x.name = abrv
          x.save
      end

  end
 

end
