require 'csv'

class Dvp < ApplicationRecord
    attr_accessor :dvp_file

    def import_dvp
      
    #Clear the db so i Overwrite instead of extend
    Dvp.delete_all
    
    
    CSV.foreach(dvp_file.path, encoding: "bom|utf-8", headers: :true) do |row|
        row[1] = "BKN" if row[1].start_with?("BRO")
        row[1] = "OKC" if row[1].start_with?("OKL")
        row[1] = "SAS" if row[1] =~ /\bSA\b/
        row[1] = "GSW" if row[1].start_with?("GS")
        row[1] = "PHX" if row[1].start_with?("PHO")
        row[1] = "OKC" if row[1].start_with?("OKL")
        row[1] = "NYK" if row[1].start_with?("NY")
        row[1] = "NOP" if row[1].start_with?("NO")
        hash = {
            pos: row[0].gsub(/\s.+/,''),
            team: row[1].gsub(/\s.+/,''),
            pts: row[2].gsub(/\s.+/,''),
            fgp: row[3].gsub(/\s.+/,''),
            ftp: row[4].gsub(/\s.+/,''),
            thrs: row[5].gsub(/\s.+/,''),
            rbs: row[6].gsub(/\s.+/,''),
            ast: row[7].gsub(/\s.+/,''),
            stl: row[8].gsub(/\s.+/,''),
            blk: row[9].gsub(/\s.+/,''),
            to: row[10].gsub(/\s.+/,''),
            
        }
      Dvp.create!(hash)
    end
    transfer_stats_to_teams
    end

    def transfer_stats_to_teams
        #for each row in the dvp table
        # get team record matching row.team
        # if row.pos is 'PG', 
         # set record.pts_to_pg = row.pts.to_f
         Dvp.find_each do |row|
            team_record = Team.find_by! name: row.team
            
            
            case row.pos
            when "PG"
                team_record.pts_to_pg = row.pts.to_f
                team_record.rbs_to_pg = row.rbs.to_f
                team_record.ast_to_pg = row.ast.to_f
                team_record.blks_to_pg = row.blk.to_f
                team_record.stl_to_pg = row.stl.to_f
                team_record.thrs_to_pg = row.thrs.to_f
                team_record.save
                pp row
            when "SG"
                team_record.pts_to_sg = row.pts.to_f
                team_record.rbs_to_sg = row.rbs.to_f
                team_record.ast_to_sg = row.ast.to_f
                team_record.blks_to_sg = row.blk.to_f
                team_record.stl_to_sg = row.stl.to_f
                team_record.thrs_to_sg = row.thrs.to_f
                team_record.save
                pp row
            when "PF"
                team_record.pts_to_pf = row.pts.to_f
                team_record.rbs_to_pf = row.rbs.to_f
                team_record.ast_to_pf = row.ast.to_f
                team_record.blks_to_pf = row.blk.to_f
                team_record.stl_to_pf = row.stl.to_f
                team_record.thrs_to_pf = row.thrs.to_f
                team_record.save
                pp row

            when "SF"
                team_record.pts_to_sf = row.pts.to_f
                team_record.rbs_to_sf = row.rbs.to_f
                team_record.ast_to_sf = row.ast.to_f
                team_record.blks_to_sf = row.blk.to_f
                team_record.stl_to_sf = row.stl.to_f
                team_record.thrs_to_sf = row.thrs.to_f
                team_record.save
                pp row

            when "C"
                team_record.pts_to_c = row.pts.to_f
                team_record.rbs_to_c = row.rbs.to_f
                team_record.ast_to_c = row.ast.to_f
                team_record.blks_to_c = row.blk.to_f
                team_record.stl_to_c = row.stl.to_f
                team_record.thrs_to_c = row.thrs.to_f
                team_record.save
                pp row

                
            end
        end







         

    end
end
