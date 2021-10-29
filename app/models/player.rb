require 'csv'
class Player < ApplicationRecord
    attr_accessor :file
    
    def import()

        #Clear the player db so i Overwrite instead of extend
        Player.delete_all

        CSV.foreach(file.path, headers: true) do |row|
          Player.create!(row.to_hash)
        end

        #Here I can also change the team names

        #Also create the teams when importing the players
        teamnames = ["ATL","NOP","MIA","POR","LAL","OKC","CHA","ORL","WAS","BOS",
            "MIN","MIL","IND","BKN","TOR","PHX","SAC","CLE","LAC","MEM",
            "PHI","CHI","DEN","SAS","HOU","DAL","UTA","NYK", "DET", "GSW"]
  
        Team.delete_all
  
        teamnames.each do |abrv|
            x = Team.new
            x.name = abrv
            x.save
        end

    end
  
end
