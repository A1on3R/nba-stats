require 'csv'
class Result < ApplicationRecord
  attr_accessor :salary_file
  belongs_to :player
  belongs_to :team

  

  def import_salaries
    Result.delete_all
    CSV.foreach(salary_file.path, headers: false) do |row|
    #Find opponent
    #get the entry with the game info
    if row[8] != "0"
    
    gameinfo = row[6].gsub(/\s.+/,'')
    
    matchup = gameinfo.split("@")
   
    row[7] == matchup[1] ? opp = matchup[0] : opp = matchup[1]
    puts(row[7])
    
      
    
    opp_record = Team.find_by! name: opp
    


    #find player
    player_record = Player.find_by! fname: row[2].tr('.',"")
    hash = {
      player: player_record,
      team: opp_record,
      salary: row[5],
      pos: row[0],
    }
    Result.create!(hash)
  end
end
end
end
