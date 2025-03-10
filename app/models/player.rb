require 'csv'
class Player < ApplicationRecord
    attr_accessor :file
    
    def import()
        Result.delete_all

        #Clear the player db so i Overwrite instead of extend
        Player.delete_all

      
        CSV.foreach(file.path, encoding: "bom|utf-8", headers: :first_row) do |row|

            #put these in a dictionary later
            #These are players who's names are different in the salary sheet
            # row[1] = "KJ Martin" if row[1].start_with?("Kenyon Martin Jr.")
            # row[1] = "Robert Williams" if row[1].start_with?("Robert Williams III")
            # row[1] = "Bones Hyland" if row[1].start_with?("Nah'Shon Hyland")
            # row[1] = "Moe Harkless" if row[1].start_with?("Maurice Harkless")
            # row[1] = "Xavier Tillman" if row[1].start_with?("Xavier Tillman Sr.")
            # row[1] = "RJ Nembhard" if row[1].start_with?("RJ Nembhard Jr.")
            # row[1] = "Greg Brown" if row[1].start_with?("Greg Brown III")
            # row[1] = "Guillermo Hernangomez" if row[1].start_with?("Willy Hernangomez")
            # row[1] = "Luka Doncic" if row[1].start_with?("Luka Dončić")
            row[1] = "Nikola Jokic" if row[1].start_with?("Nikola Jokić")
            row[1] = "Nikola Vucevic" if row[1].start_with?("Nikola Vučević")
            row[1] = "Luka Doncic" if row[1].start_with?("Luka Dončić")
            row[1] = "Alperen Sengun" if row[1].start_with?("Alperen Şengün")
            row[1] = "Nikola Vucevic" if row[1].start_with?("Nikola Vučević")
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
