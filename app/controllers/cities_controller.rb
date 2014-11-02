class CitiesController < ApplicationController
	include CitiesHelper
	#include BotHelper

	def index
			welcome_message = "Time for a road trip! Tell me where you’re at so I can tell you where to meet up. \“I can’t make it\” is not an acceptable answer."
			locations = []

			Incomings.all.each do |incoming|
				locations.push(incoming.text)
			end

			Incomings.all.each do |i|
				i.destroy
			end

			Yo.all.each do |y|
				y.destroy
			end

			@resultingPlace = find_destination(locations, 1)
			@pictureUrl = getMapUrl(locations)

			google_places_client = GooglePlaces::Client.new(GOOGLE_PLACES_API_KEY)
			restaurant = get_restaurant(google_places_client, @resultingPlace)
			entertainment = get_entertainment(google_places_client, @resultingPlace)

			groupme_client = GroupMe::Client.new(:token => ACCESS_TOKEN)
		
					sleep(2)
					priceline = get_hotel_information(@resultingPlace, Date.new(2014, 11, 7), 3)
					priceline_link = priceline[0]
					priceline_cost = priceline[1]

					bot_message = "All right, the best place to meet up is " + @resultingPlace.city_state + ". \“I’m broke\” is also not an excuse, because you can get a very affordable hotel room at Priceline here for $" + priceline_cost.round(3).to_s + ": " + priceline_link + "." + "Here is a good restaurant in the area: " + restaurant.name + ", and here is a great " + entertainment.type[0].gsub('_',' ') + ': ' + entertainment.name + '.'

					uri = URI(BASE_URL + '/bots/post')
					Net::HTTP.post_form(uri, {bot_id: BOT_ID_GetMeThere, text: bot_message, picture_url: @pictureUrl})
	end
end
