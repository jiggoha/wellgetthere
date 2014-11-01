module BotHelper
	def get_hotel_information(city, date, duration)
		connection = Faraday.new 'http://www.priceline.com' do |conn|
			conn.request :json, :content_type => 'application/json'
			conn.adapter Faraday.default_adapter
		end
		appended = '/api/hotelretail/listing/v3/' + city.latitude.to_s + ',' + city.longitude.to_s + '/' + date.to_s(:number) + '/' + (date+duration).to_s(:number) + '/1/1'
		binding.pry
		response = connection.get appended
	end
end
