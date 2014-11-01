module BotHelper
	#moved to CitiesHelper
	# def get_hotel_information(city, date, duration)
	# 	connection = Faraday.new('http://www.priceline.com') do |conn|
	# 		conn.response :json, :content_type => 'application/json'
	# 		conn.adapter Faraday.default_adapter
	# 	end
	# 	appended = '/api/hotelretail/listing/v3/' + city.latitude.to_s + ',' + city.longitude.to_s + '/' + date.to_s(:number) + '/' + (date+duration).to_s(:number) + '/1/1?sort=2'
	# 	response = connection.get(appended)
	# 	id = response.body["hotels"].keys[0]
	# 	return "http://www.priceline.com/hotel/hotelOverviewGuide.do?propID=" + id.to_s, response.body["hotels"].first[1]["merchPrice"]
	# end
end
