require 'csv'
class Result < ApplicationRecord
  attr_accessor :salary_file, :minutes_file
  belongs_to :player
  belongs_to :team

  PLAYER_NAME_MAP = {
  "Alexandre Sarr" => "Alex Sarr",
  "Carlton Carrington" => "Bub Carrington",
  "Ronald Holland II" => "Ron Holland",
  "Tristan da Silva" => "Triston Da Silva",
  "Kevin Knox II" => "Kevin Knox",
}

  

  def import_salaries
    Result.delete_all
    CSV.foreach(salary_file.path, encoding: "bom|utf-8", headers: :first_row) do |row|
    #Find opponent by looking at the 2 teams and seeing which doesnt match the row that corresponds to the players team
    #get the entry with the game info
        if row[8] != "0"
        #getting the string before the first space
        gameinfo = row[6].gsub(/\s.+/,'')    
        matchup = gameinfo.split("@")     
        row[7] == matchup[1] ? opp = matchup[0] : opp = matchup[1]
        puts(row[7])
        
        opp_record = Team.find_by! name: opp
        
        #find player
        player_name = row[2].tr('.', "")

        begin
          player_record = Player.find_by! fname: player_name
          if player_record.teamname.match?(/\dTM/)
            last_known_team = Player.where(fname: player_name)
                                    .where.not(teamname: ["2TM", "3TM", "4TM"])
                                    .order(created_at: :desc)
                                    .pluck(:teamname)
                                    .first
        
            if last_known_team
              player_record.update!(teamname: last_known_team) # Assign correct team
              puts "Updated #{player_name} to team #{last_known_team}"
            else
              puts "No valid team found for #{player_name}"
            end
          end
        rescue ActiveRecord::RecordNotFound
          puts "Player '#{player_name}' not found. Looking for correct name:"
          corrected_name = PLAYER_NAME_MAP[player_name] || player_name
          if corrected_name == player_name
            puts "Player not in dict. Enter their name"
            corrected_name = gets.chomp
          end
          
          begin

            player_record = Player.find_by!(fname: corrected_name)
          rescue ActiveRecord::RecordNotFound
            puts "Player not found in slate"
            player_record = []
          end
        end

        hash = {
          player: player_record,
          team: opp_record,
          salary: row[5],
          pos: row[0],
          
        }
        if player_record != []
          Result.create!(hash)
          
        end
         end
        end
    end

def project()
  Result.find_each do |row|
    @result = row
    project_player(row)



end
end

def set_minutes
  # CSV.foreach(minutes_file.path, headers: false) do |row|
  #   #get row name string to search in Result table for the player and update that result with the minutes from the uploaded shee
  #   x = Result.joins(:player).where(:players => {:fname => row[0].split("  ")[0].tr('.','')})
  #   x.update(numberfiremins: row[5].to_f)
  url = "https://www.sportsline.com/nba/expert-projections/simulation/"
  response = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(response.body)
  
  # Select the correct table (change index if needed)
  tables = parsed_page.css('table')
  selected_table = tables[0]
  selected_table.css('tr')[1..].each do |row|
      columns = row.css('td').map(&:text).map(&:strip)
    
      next if columns.empty? # Skip empty rows
      x = Result.joins(:player).where(:players => {:fname => columns[0].split("  ")[0].tr('.','')})
      x.update(numberfiremins: columns[9].to_f)

      end
  project
  
end

def project_player(result)
  #mins is 0 it isnt ever set
  return if result.player.teamname == "2TM" # I still need to account for players on multiple teams or find a source that lists them once,
                                            # or get the current team from the matchup info?
  mins = result.numberfiremins ? result.numberfiremins : 0
  if result.pos.include?('/')
    #swap the positions when I project a player with multiple positions
    positions = result.pos.split('/')
    
    result.pos = positions[1] + '/' + positions[0]
    result.save 
  end

  #Based on the position, project the players stats
  case result.pos.split("/")[0]
  when "PG"
    result.projrbs = ((result.player.rpg/result.player.mpg) * mins * (result.team.rbs_to_pg/Team.average(:rbs_to_pg))).truncate(2)  
    result.projpts = ((result.player.ppg/result.player.mpg) * mins * (result.team.pts_to_pg/Team.average(:pts_to_pg))).truncate(2)
    result.projast = ((result.player.apg/result.player.mpg) * mins * (result.team.ast_to_pg/Team.average(:ast_to_pg))).truncate(2)  
    result.projstls = ((result.player.spg/result.player.mpg) * mins * (result.team.stl_to_pg/Team.average(:stl_to_pg))).truncate(2)  
    result.projblks = ((result.player.bpg/result.player.mpg) * mins * (result.team.blks_to_pg/Team.average(:blks_to_pg))).truncate(2)  
    result.projthrs = ((result.player.thpg/result.player.mpg) * mins * (result.team.thrs_to_pg/Team.average(:thrs_to_pg))).truncate(2)
    #Draftkings Formula
    result.projfpts = (result.projpts + (result.projrbs * 1.25) + (result.projast * 1.5) + (result.projstls * 2) + (result.projblks * 2) + (result.projthrs * 0.5)).truncate(2)   
    #projected fantasy points for every 1000 dollars spent on the player. 
    result.projval = (result.projfpts/(result.salary/1000)).truncate(2)
    
    result.save
  when "SG"
    result.projpts = ((result.player.ppg/result.player.mpg) * mins * (result.team.pts_to_sg/Team.average(:pts_to_sg))).truncate(2)
    result.projrbs = ((result.player.rpg/result.player.mpg) * mins * (result.team.rbs_to_sg/Team.average(:rbs_to_sg))).truncate(2)  
    result.projast = ((result.player.apg/result.player.mpg) * mins * (result.team.ast_to_sg/Team.average(:ast_to_sg))).truncate(2)  
    result.projstls = ((result.player.spg/result.player.mpg) * mins * (result.team.stl_to_sg/Team.average(:stl_to_sg))).truncate(2)  
    result.projblks = ((result.player.bpg/result.player.mpg) * mins * (result.team.blks_to_sg/Team.average(:blks_to_sg))).truncate(2)  
    result.projthrs = ((result.player.thpg/result.player.mpg) * mins * (result.team.thrs_to_sg/Team.average(:thrs_to_sg))).truncate(2)
    result.projfpts = (result.projpts + (result.projrbs * 1.25) + (result.projast * 1.5) + (result.projstls * 2) + (result.projblks * 2) + (result.projthrs * 0.5)).truncate(2)   
    result.projval = (result.projfpts/(result.salary/1000)).truncate(2)
    
    result.save  
  when "PF"
    result.projpts = ((result.player.ppg/result.player.mpg) * mins * (result.team.pts_to_pf/Team.average(:pts_to_pf))).truncate(2)
    result.projrbs = ((result.player.rpg/result.player.mpg) * mins * (result.team.rbs_to_pf/Team.average(:rbs_to_pf))).truncate(2)  
    result.projast = ((result.player.apg/result.player.mpg) * mins * (result.team.ast_to_pf/Team.average(:ast_to_pf))).truncate(2)  
    result.projstls = ((result.player.spg/result.player.mpg) * mins * (result.team.stl_to_pf/Team.average(:stl_to_pf))).truncate(2)  
    result.projblks = ((result.player.bpg/result.player.mpg) * mins * (result.team.blks_to_pf/Team.average(:blks_to_pf))).truncate(2)  
    result.projthrs = ((result.player.thpg/result.player.mpg) * mins * (result.team.thrs_to_pf/Team.average(:thrs_to_pf))).truncate(2)  
    result.projfpts = (result.projpts + (result.projrbs * 1.25) + (result.projast * 1.5) + (result.projstls * 2) + (result.projblks * 2) + (result.projthrs * 0.5)).truncate(2)   
    result.projval = (result.projfpts/(result.salary/1000)).truncate(2)
    
    result.save
  when "SF"
    result.projpts = ((result.player.ppg/result.player.mpg) * mins * (result.team.pts_to_sf/Team.average(:pts_to_sf))).truncate(2)
    result.projrbs = ((result.player.rpg/result.player.mpg) * mins * (result.team.rbs_to_sf/Team.average(:rbs_to_sf))).truncate(2)  
    result.projast = ((result.player.apg/result.player.mpg) * mins * (result.team.ast_to_sf/Team.average(:ast_to_sf))).truncate(2)  
    result.projstls = ((result.player.spg/result.player.mpg) * mins * (result.team.stl_to_sf/Team.average(:stl_to_sf))).truncate(2)  
    result.projblks = ((result.player.bpg/result.player.mpg) * mins * (result.team.blks_to_sf/Team.average(:blks_to_sf))).truncate(2)  
    result.projthrs = ((result.player.thpg/result.player.mpg) * mins * (result.team.thrs_to_sf/Team.average(:thrs_to_sf))).truncate(2)  
    result.projfpts = (result.projpts + (result.projrbs * 1.25) + (result.projast * 1.5) + (result.projstls * 2) + (result.projblks * 2) + (result.projthrs * 0.5)).truncate(2)   
    result.projval = (result.projfpts/(result.salary/1000)).truncate(2)
    
    result.save
  when "C"
    result.projpts = ((result.player.ppg/result.player.mpg) * mins * (result.team.pts_to_c/Team.average(:pts_to_c))).truncate(2)
    result.projrbs = ((result.player.rpg/result.player.mpg) * mins * (result.team.rbs_to_c/Team.average(:rbs_to_c))).truncate(2)  
    result.projast = ((result.player.apg/result.player.mpg) * mins * (result.team.ast_to_c/Team.average(:ast_to_c))).truncate(2)  
    result.projstls = ((result.player.spg/result.player.mpg) * mins * (result.team.stl_to_c/Team.average(:stl_to_c))).truncate(2)  
    result.projblks = ((result.player.bpg/result.player.mpg) * mins * (result.team.blks_to_c/Team.average(:blks_to_c))).truncate(2)  
    result.projthrs = ((result.player.thpg/result.player.mpg) * mins * (result.team.thrs_to_c/Team.average(:thrs_to_c))).truncate(2)  
    result.projfpts = (result.projpts + (result.projrbs * 1.25) + (result.projast * 1.5) + (result.projstls * 2) + (result.projblks * 2) + (result.projthrs * 0.5)).truncate(2)   
    result.projval = (result.projfpts/(result.salary/1000)).truncate(2)
    
    result.save
end


end


end
