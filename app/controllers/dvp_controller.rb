class DvpController < ApplicationController
def index
    @dvps=Dvp.all
end

def upload_dvp
end

def import_dvp
    require 'csv'
    myfile = params[:dvp_file]
    

    #Clear the player db so i Overwrite instead of extend
    Dvp.delete_all
    

    CSV.foreach(myfile.path, headers: false) do |row|
        hash = {
            pos: row[0],
            team: row[1],
            pts: row[2],
            fgp: row[3],
            thrs: row[4],
            rbs: row[5],
            stl: row[6],
            to: row[7],
            
        }
      Dvp.create!(hash)
    end
   

      redirect_to action: "index"
    
end
end