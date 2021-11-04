class ResultsController < ApplicationController
    def index
        @results=Result.all
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
    end