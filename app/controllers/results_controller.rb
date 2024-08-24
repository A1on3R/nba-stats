class ResultsController < ApplicationController
    def index
        @results=Result.order(:projval).reverse_order
    end
    
    def upload_salaries
    end
    
    def upload_minutes
       
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
