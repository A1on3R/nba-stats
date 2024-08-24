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
            row[1] = "KJ Martin" if row[1].start_with?("Kenyon Martin Jr.")
            row[1] = "Cameron Thomas" if row[1].start_with?("Cam Thomas")
            row[1] = "Robert Williams" if row[1].start_with?("Robert Williams III")
            row[1] = "Bones Hyland" if row[1].start_with?("Nah'Shon Hyland")
            row[1] = "Moe Harkless" if row[1].start_with?("Maurice Harkless")
            row[1] = "Xavier Tillman" if row[1].start_with?("Xavier Tillman Sr.")
            row[1] = "RJ Nembhard" if row[1].start_with?("RJ Nembhard Jr.")
            row[1] = "Greg Brown" if row[1].start_with?("Greg Brown III")
            row[1] = "Guillermo Hernangomez" if row[1].start_with?("Willy Hernangomez")
            row[1] = "Nicolas Claxton" if row[1].start_with?("Nic Claxton")
            row[1] = row[1].tr('.', "")
            
            
            hash = {
             fname: row[1],
             teamname: row[2],
             pos: row[3],
             gp: row[5],
             thpg: (row[15].to_f * (row[14].to_f / row[5].to_f)).truncate(2).to_s,
             mpg: row[6],
             usg: row[8],
             efg: row[16],
             ts: row[17],
             ppg: row[18],
             rpg: row[19],
             apg: row[21],
            spg: row[23],
            bpg: row[24],
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
