require 'csv'
class Player < ApplicationRecord
    attr_accessor :file
    
    def import()
        Result.delete_all

        #Clear the player db so i Overwrite instead of extend
        Player.delete_all

        CSV.foreach(file.path, headers: true) do |row|
          Player.create!(row.to_hash)
        end
        #trying to make all names match better 
        Player.find_each do |player|
            if player.fname == "Kenyon Martin Jr."
                player.fname = "KJ Martin"
                player.save
            elsif player.fname == "Cam Thomas"
                player.fname = "Cameron Thomas"
                player.save
            else

                player.fname = player.fname.tr('.',"")
                player.save
            end
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
