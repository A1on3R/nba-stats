require 'csv'
class Player < ApplicationRecord
    attr_accessor :file
    
    def import()
        Result.delete_all

        #Clear the player db so i Overwrite instead of extend
        Player.delete_all

      
        CSV.foreach(file.path, encoding: "bom|utf-8", headers: :first_row) do |row|

            #if names are not matching, we might fix it here but I made it so you can fix it with a prompt
            row[1] = I18n.transliterate(row[1])
            row[1] = row[1].tr('.', "")
            
            
            hash = {
             fname: row[1],
             teamname: row[3],
             pos: row[4],
             gp: row[5],
             thpg: row[11],
             mpg: row[7],
             
             ppg: row[29],
             rpg: row[23],
             apg: row[24],
            spg: row[25],
            bpg: row[26],
            }
            Player.create!(hash)
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
