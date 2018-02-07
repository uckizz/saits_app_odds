class WelcomeController < ApplicationController
    before_action :getGameday, only:[:home]
    def home
        ##Arsenal vs manchester
        
        key = {:api_key => "e874f10cac21495b8fc51f14ca1da82e"}
        response = HTTParty.get('http://api.football-data.org//v1/competitions/445/fixtures',
        :basic_auth => key)
        @json = JSON.parse(response.body)
        
        
        #@scheduledgames = ScheduledGame.where(matchday: 27)
        ScheduledGame.all.each do |game|
            homedrawaway = getLatest(game.hometeam,game.awayteam,5)
        
            game.update_attribute(:homebet, homedrawaway["home"])
            game.update_attribute(:drawbet,  homedrawaway["draw"])
            game.update_attribute(:awaybet, homedrawaway["away"])
            
        end
        @scheduledgames = ScheduledGame.where(matchday: 27)
        #@playedgames = PlayedGame.limit(5).where(["hometeam = 'Arsenal FC' and awayteam = 'Manchester City FC'"])
        #@playedgames = PlayedGame.all
        @test = getLatest("Arsenal FC","Manchester United FC",5)
    end

    def addtoDB
        key = {:api_key => "e874f10cac21495b8fc51f14ca1da82e"}
        response = HTTParty.get('http://api.football-data.org//v1/competitions/445/fixtures',
        :basic_auth => key)
        json = JSON.parse(response.body)
        json["fixtures"].each do |match|
            if match["status"] == "FINISHED"
                new_record = PlayedGame.new
                new_record.hometeam = match["homeTeamName"]
                new_record.awayteam = match["awayTeamName"]
                new_record.homescore = match["result"]["goalsHomeTeam"]
                new_record.awayscore = match["result"]["goalsAwayTeam"]
                new_record.date = match["date"]                
                new_record.matchday = match["matchday"]
                new_record.save
            else
                new_record = ScheduledGame.new
                new_record.hometeam = match["homeTeamName"]
                new_record.awayteam = match["awayTeamName"]
                new_record.matchday = match["matchday"]
                new_record.save
            end	
        end
    end

    def getLatest(hometeamIN,awayteamIN,numGames)
    	hometenlatest = PlayedGame.where(hometeam: hometeamIN).limit(numGames)
    	awaytenlatest = PlayedGame.where(awayteam: awayteamIN).limit(numGames)
    	return calculateodds(calculatewdl(hometenlatest),calculatewdl(awaytenlatest))
    end

    def calculatewdl(tenlatest)
    	wdltenlatest = {:win => 0,:draw => 0, :lose =>0}
    
    	tenlatest.each do |temp|
    		if temp.homescore > temp.awayscore
    			wdltenlatest[:win] +=1
    		elsif temp.homescore == temp.awayscore
    			wdltenlatest[:draw] += 1
    		else
    			wdltenlatest[:lose] += 1
    		end
    	end
    	return wdltenlatest
    end
    
    def calculateodds(hometeamwdl,awayteamwdl)
    	wdlodds = {:home => 0,:draw => 0, :away =>0}
    	
    	home = ((hometeamwdl[:win] + awayteamwdl[:lose]) / 20.0)*100
    	wdlodds[:home] = 100/home
    
    	draw = ((hometeamwdl[:draw]+awayteamwdl[:draw])/20.0)*100
    	wdlodds[:draw] = 100/draw
    
    	away = ((hometeamwdl[:lose]+awayteamwdl[:win])/20.0)*100
    	wdlodds[:away] = 100/away
    	return wdlodds
    end

    private
    def getGameday
        key = {:api_key => "e874f10cac21495b8fc51f14ca1da82e"}
        response = HTTParty.get('http://api.football-data.org/v1/competitions/445/',
        :headers => {"Authorization" => "e874f10cac21495b8fc51f14ca1da82e"})
        json = JSON.parse(response.body)
        @currentGameday = json["currentMatchday"]
    end

end