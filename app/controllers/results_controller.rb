class ResultsController < ApplicationController
  
    def index
        sort_column = params[:sort] || "projval"  # Default sorting column
        sort_order = params[:direction] == "desc" ? "DESC" : "ASC"
        puts "YOOOOO"
      
        if sort_column == "players.fname"
            
        
            
          @results = Result.joins(:player).order("players.fname #{sort_order}")
        elsif sort_column == "players.teamname"
          @results = Result.joins(:player).order("players.teamname #{sort_order}")
        elsif sort_column == "players.pos"
          @results = Result.joins(:player).order("players.pos #{sort_order}")
        else

          puts "WHATSS UPPP???"
          @results = Result.order("#{sort_column} #{sort_order}")
        end
      end
    
    def upload_salaries
    end
    
    def upload_minutes
       
    end
    def run_simulation
        Player.import()
        Dvp.import_dvp()
        


    end
    def set_minutes
        result_obj = Result.new
        result_obj.minutes_file = params[:minutes_file]
        result_obj.set_minutes()
        redirect_to action: "index"

    end
    
    def import_salaries
        
        result_obj = Result.new
        result_obj.salary_file = params[:salary_file]
        result_obj.import_salaries()
        redirect_to action: "index"
        
    end

    def update()
        @result = Result.find(params[:id])
        @result.project_player(@result)
        puts("PROJECTED " + @result.player.fname.to_s)
        redirect_to action: "index"
        
    end
    private
    def result_params
        params.require(:result).permit(:pos)
      end
    end
