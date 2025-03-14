require 'csv'
class Player < ApplicationRecord
    attr_accessor :file
    
    def import()
        Result.delete_all

        #Clear the player db so i Overwrite instead of extend
        Player.delete_all
        url = "https://www.basketball-reference.com/leagues/NBA_2025_per_game.html"
        response = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(response.body)
        tables = parsed_page.css('table')
        selected_table = tables[0]
        # Iterate over table rows
        selected_table.css('tr')[1..].each do |row|  # Skip header row
          columns = row.css('td').map(&:text)
        
          next if columns.empty?  # Skip empty rows
        
          # Process the data similar to how you did with CSV
          columns[0] = I18n.transliterate(columns[0]).tr('.', '')
        
          hash = {
            fname: columns[0],
            teamname: columns[2],
            pos: columns[3],
            gp: columns[4],
            thpg: columns[10],
            mpg: columns[6],
            ppg: columns[28],
            rpg: columns[22],
            apg: columns[23],
            spg: columns[24],
            bpg: columns[25]
          }
        
          Player.create!(hash)


      
        # CSV.foreach(file.path, encoding: "bom|utf-8", headers: :first_row) do |row|

        #     #if names are not matching, we might fix it here but I made it so you can fix it with a prompt
        #     row[1] = I18n.transliterate(row[1])
        #     row[1] = row[1].tr('.', "")
            
            
        #     hash = {
        #      fname: row[1],
        #      teamname: row[3],
        #      pos: row[4],
        #      gp: row[5],
        #      thpg: row[11],
        #      mpg: row[7],
             
        #      ppg: row[29],
        #      rpg: row[23],
        #      apg: row[24],
        #     spg: row[25],
        #     bpg: row[26],
        #     }
        #     Player.create!(hash)
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
