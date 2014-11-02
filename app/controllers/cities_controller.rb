class CitiesController < ApplicationController
	include CitiesHelper
	#include BotHelper

	def index
			welcome_message = "Time for a road trip! Tell me where you’re at so I can tell you where to meet up. \“I can’t make it\” is not an acceptable answer."
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
			@resultingPlace = find_destination(@locations, 1)
			@pictureUrl = getMapUrl(@locations)

			@client = GroupMe::Client.new(:token => ACCESS_TOKEN)
			@counter = 1
			if !@resultingPlace.nil?
					sleep(2)
					priceline = get_hotel_information(@resultingPlace, Date.new(2014, 11, 7), 3)
					priceline_link = priceline[0]
					priceline_cost = priceline[1]
					bot_message = "All right, the best place to meet up is " + @resultingPlace.city_state + ". \“I’m broke\” is also not an excuse, because you can get a dead cheap hotel room at Priceline here for $" + priceline_cost.round(3).to_s + ": " + priceline_link
					uri = URI(BASE_URL + '/bots/post')
					Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere, text: bot_message, picture_url: @pictureUrl})

					#@client.create_message(ENV['GROUP_ID'], "Calculated option number " + @counter.to_s + ": " + nameOfPlace + "\n")

					# @counter += 1
				
			end
	end
end
