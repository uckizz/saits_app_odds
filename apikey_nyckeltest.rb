class WelcomeController < ApplicationController
    def home
        auth = {:username => "", :password => "e874f10cac21495b8fc51f14ca1da82e"}
        # Use the class methods to get down to business quickly
    response = HTTParty.get('http://api.football-data.org/v1/competitions/445/fixtures',
        :basic_auth => auth)
    @response = response.body
    end
end