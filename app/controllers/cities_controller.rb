class CitiesController < ApplicationController
	include CitiesHelper

	def index
		@locations = params[:locations]	
		
		@resultingPlaces = find_destination(@locations, 7endend)
		@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		@counter = 1
		if !@resultingPlaces.empty?
			@resultingPlaces.each do |nameOfPlace|
				@client.create_message(GROUP_ID, "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n")
				@counter += 1
			end
		end
	end
end
