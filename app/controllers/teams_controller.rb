class TeamsController < ApplicationController
    def index
      @teams = Team.all
    end
    def create_teams
      teamnames = ["ATL","NOP","MIA","POR","LAL","OKC","CHA","ORL","WAS","BOS",
          "MIN","MIL","IND","BKN","TOR","PHX","SAC","CLE","LAC","MEM",
          "PHI","CHI","DEN","SAS","HOU","DAL","UTA","NYK"]

      Team.delete_all

      teamnames.each do |abrv|
          x = Team.new
          x.name = abrv
          x.save
      end

  end

   
end