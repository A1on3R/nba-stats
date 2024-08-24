class DvpController < ApplicationController
    def index
        @dvps=Dvp.all
    end
    
    def upload_dvp
    end
    
    def import_dvp
        
        dvp_obj = Dvp.new
        dvp_obj.dvp_file = params[:dvp_file]
        dvp_obj.import_dvp()
        redirect_to action: "index"
        
    end
    end