class TeamsController < ApplicationController
    def index
      @teams = Team.all
      @team_table_html
    end
 
  
   
end