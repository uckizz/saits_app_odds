
class WelcomeController < ApplicationController
    before_action :getGameday, only:[:home]
    def home
        ##Arsenal vs manchester
        @playedgames = PlayedGame.where(matchday: @currentGameday + 1)
        #@playedgames = PlayedGame.limit(5).where(["hometeam = 'Arsenal FC' and awayteam = 'Manchester City FC'"])
        #@playedgames = PlayedGame.all
    end

    def addtoDB
        key = {:api_key => "e874f10cac21495b8fc51f14ca1da82e"}
        response = HTTParty.get('http://api.football-data.org//v1/competitions/445/fixtures',
        :basic_auth => key)
    json = JSON.parse(response.body)
        json["fixtures"].each do |match|
                new_record = PlayedGame.new
                new_record.hometeam = match["homeTeamName"]
                new_record.awayteam = match["awayTeamName"]
                new_record.homescore = match["result"]["goalsHomeTeam"]
                new_record.awayscore = match["result"]["goalsAwayTeam"]
                new_record.date = match["date"]
                new_record.matchday = match["matchday"]
                new_record.save
        end	
    end

    private
    def getGameday
        key = {:api_key => "e874f10cac21495b8fc51f14ca1da82e"}
        response = HTTParty.get('http://api.football-data.org//v1/competitions/445/',
        :basic_auth => key)
    json = JSON.parse(response.body)
    @currentGameday = json["currentMatchday"]
    end

    end