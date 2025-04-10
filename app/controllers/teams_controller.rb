class TeamsController < ApplicationController
    def index
      @teams = Team.all
      @team_table_html
    end
    def update
      @team = Team.find(params[:id])
      if @team.update(team_params)
        redirect_to teams_path, notice: "Pacing updated!"
      else
        render :index, alert: "Error updating pacing."
      end
    end
    
    private
    
    def team_params
      params.require(:team).permit(:pacing)
    end
 
  
   
end