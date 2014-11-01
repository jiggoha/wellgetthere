class CitiesController < ApplicationController
	include CitiesHelper

	def index

			@locations = []

			Incomings.all.each do |incoming|
				@locations.push(incoming.text)
			end

			Incomings.all.each do |i|
				i.destroy
			end

			Yo.all.each do |y|
				y.destroy
			end

			@resultingPlaces = find_destination(@locations, 3)
			@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
			@counter = 1
			if !@resultingPlaces.empty?
				@resultingPlaces.each do |nameOfPlace|
					sleep(2)
					@client.create_message(GROUP_ID, "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n")
					@counter += 1
				end
			end
	end
end
