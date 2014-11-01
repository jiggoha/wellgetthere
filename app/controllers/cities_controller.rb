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

					uri = URI(BASE_URL + '/bots/post')
					Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere, text: "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n"})

					#@client.create_message(ENV['GROUP_ID'], "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n")

					@counter += 1
				end
			end
	end
end
