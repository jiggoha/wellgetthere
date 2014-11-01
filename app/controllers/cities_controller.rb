class CitiesController < ApplicationController
	include CitiesHelper

	def index

			# @locations = []

			# Incomings.all.each do |incoming|
			# 	@locations.push(incoming.text)
			# end
			# Incomings.all.destroy
			# Yo.all.destroy

			# @resultingPlaces = find_destination(@locations, 3)
			# @client = GroupMe::Client.new(:token => ENV['ACCESS_TOKEN'])
			# @counter = 1
			# if !@resultingPlaces.empty?
			# 	@resultingPlaces.each do |nameOfPlace|
			# 		sleep(2)
			# 		@client.create_message(GROUP_ID, "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n")
			# 		@counter += 1
			# 	end
			# end
	end
end
