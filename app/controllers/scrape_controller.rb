#require 'HTTParty'
#require 'Nokogiri'
#require 'JSON'
#require 'Pry'
#require 'csv'

#Bookmaker id, w, d, l, match-id

class ScrapeController < ActionController::Base
    def home
        
        
        page = HTTParty.get("https://www.betbrain.se/football/england/premier-league/")
        parse_page = Nokogiri::HTML(page)
        #Pry.start(binding)
        
        #parse_page.css('matcher').css('.odds').map do |a|
            #odds_to_get = a.text
            #match_array.push(odds.to)
        homeTeamArray = []
        awayTeamArray = []
        dateArray = []
        @homeOddsArray = []
        drawOddsArray = []
        awayOddsArray = []
        homeBookieArray = []
        drawBookieArray = []
        awayBookieArray = []
        temparray = []
            
        parse_page.css('.SubTabContent.SubTab1').css('.MDLink').css('span').map do |a|
            match_name = a.text
            values = match_name.split('-')
            homeTeamArray.push(values[0])
            awayTeamArray.push(values[1])
        end
       parse_page.css('.SubTabContent.SubTab1').css('.MDInfo').css('span.Setting.DateTime').map do |a|
            date = a.text
            values = date.split(' ')
            dateArray.push(values[0])
       end
       counter = 0
       
        parse_page.css('.SubTabContent.SubTab1').css('span.BM.OTBookie').map do |a|
            temparray.push(a.text)
        end
       parse_page.css('.SubTabContent.SubTab1').css('.Odds').each_with_index.map do |a,i|
           
           odds = a.text
           bookie = temparray[i]
           if counter == 0
               @homeOddsArray.push(odds)
               homeBookieArray.push(bookie)
           elsif counter == 1
               drawOddsArray.push(odds)
               drawBookieArray.push(bookie)
           else counter == 2
               awayOddsArray.push(odds)
               awayBookieArray.push(bookie)
               counter = -1
           end
            counter += 1
        
           end
        
    end
    def addScrapedOdds
        homeTeamArray.each_with_index do |a,i|
            
        new_record = BookieOdd.new
        new_record.hometeam = a
        new_record.awayteam = awayTeamArray[i]
        new_record.homeodds = homeOddsArray[i]
        new_record.drawodds = drawOddsArray[i]
        new_record.awayodds = awayOddsArray[i]
        new_record.homebookie = homeBookieArray[i]
        new_record.drawbookie = drawBookieArray[i]
        new_record.awaybookie = awayBookieArray[i]
        new_record.matchdate = dateArray[i]
        new_record.save
        end
    end

end