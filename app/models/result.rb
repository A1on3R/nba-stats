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
        row[0] = "PF" if player_record.fname == "Kevin Durant"
        hash = {
          player: player_record,
          team: opp_record,
          salary: row[5],
          pos: row[0],
          
        }
        Result.create!(hash)
         end
        end
        project
    end

def project()
  Result.find_each do |row|
    #Still need to get the projected minutes.
    mins = row.player.mpg


    case row.pos.split("/")[0]
    when "PG"
      row.projpts = ((row.player.ppg/row.player.mpg) * mins * (row.team.pts_to_pg/Team.average(:pts_to_pg))).truncate(2)
      row.projrbs = ((row.player.rpg/row.player.mpg) * mins * (row.team.rbs_to_pg/Team.average(:rbs_to_pg))).truncate(2)  
      row.projast = ((row.player.apg/row.player.mpg) * mins * (row.team.ast_to_pg/Team.average(:ast_to_pg))).truncate(2)  
      row.projstls = ((row.player.spg/row.player.mpg) * mins * (row.team.stl_to_pg/Team.average(:stl_to_pg))).truncate(2)  
      row.projblks = ((row.player.bpg/row.player.mpg) * mins * (row.team.blks_to_pg/Team.average(:blks_to_pg))).truncate(2)  
      row.projthrs = ((row.player.thpg/row.player.mpg) * mins * (row.team.thrs_to_pg/Team.average(:thrs_to_pg))).truncate(2)
      row.projfpts = (row.projpts + (row.projrbs * 1.25) + (row.projast * 1.5) + (row.projstls * 2) + (row.projblks * 2) + (row.projthrs * 0.5)).truncate(2)   
      row.projval = (row.projfpts/(row.salary/1000)).truncate(2)
      row.save
    when "SG"
      row.projpts = ((row.player.ppg/row.player.mpg) * mins * (row.team.pts_to_sg/Team.average(:pts_to_sg))).truncate(2)
      row.projrbs = ((row.player.rpg/row.player.mpg) * mins * (row.team.rbs_to_sg/Team.average(:rbs_to_sg))).truncate(2)  
      row.projast = ((row.player.apg/row.player.mpg) * mins * (row.team.ast_to_sg/Team.average(:ast_to_sg))).truncate(2)  
      row.projstls = ((row.player.spg/row.player.mpg) * mins * (row.team.stl_to_sg/Team.average(:stl_to_sg))).truncate(2)  
      row.projblks = ((row.player.bpg/row.player.mpg) * mins * (row.team.blks_to_sg/Team.average(:blks_to_sg))).truncate(2)  
      row.projthrs = ((row.player.thpg/row.player.mpg) * mins * (row.team.thrs_to_sg/Team.average(:thrs_to_sg))).truncate(2)
      row.projfpts = (row.projpts + (row.projrbs * 1.25) + (row.projast * 1.5) + (row.projstls * 2) + (row.projblks * 2) + (row.projthrs * 0.5)).truncate(2)   
      row.projval = (row.projfpts/(row.salary/1000)).truncate(2)
      
      row.save  
    when "PF"
      row.projpts = ((row.player.ppg/row.player.mpg) * mins * (row.team.pts_to_pf/Team.average(:pts_to_pf))).truncate(2)
      row.projrbs = ((row.player.rpg/row.player.mpg) * mins * (row.team.rbs_to_pf/Team.average(:rbs_to_pf))).truncate(2)  
      row.projast = ((row.player.apg/row.player.mpg) * mins * (row.team.ast_to_pf/Team.average(:ast_to_pf))).truncate(2)  
      row.projstls = ((row.player.spg/row.player.mpg) * mins * (row.team.stl_to_pf/Team.average(:stl_to_pf))).truncate(2)  
      row.projblks = ((row.player.bpg/row.player.mpg) * mins * (row.team.blks_to_pf/Team.average(:blks_to_pf))).truncate(2)  
      row.projthrs = ((row.player.thpg/row.player.mpg) * mins * (row.team.thrs_to_pf/Team.average(:thrs_to_pf))).truncate(2)  
      row.projfpts = (row.projpts + (row.projrbs * 1.25) + (row.projast * 1.5) + (row.projstls * 2) + (row.projblks * 2) + (row.projthrs * 0.5)).truncate(2)   
      row.projval = (row.projfpts/(row.salary/1000)).truncate(2)
      
      row.save
    when "SF"
      row.projpts = ((row.player.ppg/row.player.mpg) * mins * (row.team.pts_to_sf/Team.average(:pts_to_sf))).truncate(2)
      row.projrbs = ((row.player.rpg/row.player.mpg) * mins * (row.team.rbs_to_sf/Team.average(:rbs_to_sf))).truncate(2)  
      row.projast = ((row.player.apg/row.player.mpg) * mins * (row.team.ast_to_sf/Team.average(:ast_to_sf))).truncate(2)  
      row.projstls = ((row.player.spg/row.player.mpg) * mins * (row.team.stl_to_sf/Team.average(:stl_to_sf))).truncate(2)  
      row.projblks = ((row.player.bpg/row.player.mpg) * mins * (row.team.blks_to_sf/Team.average(:blks_to_sf))).truncate(2)  
      row.projthrs = ((row.player.thpg/row.player.mpg) * mins * (row.team.thrs_to_sf/Team.average(:thrs_to_sf))).truncate(2)  
      row.projfpts = (row.projpts + (row.projrbs * 1.25) + (row.projast * 1.5) + (row.projstls * 2) + (row.projblks * 2) + (row.projthrs * 0.5)).truncate(2)   
      row.projval = (row.projfpts/(row.salary/1000)).truncate(2)
      
      row.save
    when "C"
      row.projpts = ((row.player.ppg/row.player.mpg) * mins * (row.team.pts_to_c/Team.average(:pts_to_c))).truncate(2)
      row.projrbs = ((row.player.rpg/row.player.mpg) * mins * (row.team.rbs_to_c/Team.average(:rbs_to_c))).truncate(2)  
      row.projast = ((row.player.apg/row.player.mpg) * mins * (row.team.ast_to_c/Team.average(:ast_to_c))).truncate(2)  
      row.projstls = ((row.player.spg/row.player.mpg) * mins * (row.team.stl_to_c/Team.average(:stl_to_c))).truncate(2)  
      row.projblks = ((row.player.bpg/row.player.mpg) * mins * (row.team.blks_to_c/Team.average(:blks_to_c))).truncate(2)  
      row.projthrs = ((row.player.thpg/row.player.mpg) * mins * (row.team.thrs_to_c/Team.average(:thrs_to_c))).truncate(2)  
      row.projfpts = (row.projpts + (row.projrbs * 1.25) + (row.projast * 1.5) + (row.projstls * 2) + (row.projblks * 2) + (row.projthrs * 0.5)).truncate(2)   
      row.projval = (row.projfpts/(row.salary/1000)).truncate(2)
      
      row.save
  end

end
end

end
