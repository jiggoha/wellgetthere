module BotHelper
	def get_hotel_information(city, date, duration)
		connection = Faraday.new('http://www.priceline.com') do |conn|
			conn.request :json, :content_type => 'application/json'
			conn.adapter Faraday.default_adapter
		end
		start_date = date.
		end_date = date+durataion
		end_date = end_date.year.to_s + end_date.month
		appended = '/api/hotelretail/listing/v3/' + city.latitude.to_s + ',' + city.longitude.to_s + '/' + date.to_s(:number) + '/' + (date+duration).to_s(:number) + '/1/1'
		response = connection.get(appended)
		binding.pry
	end
end
