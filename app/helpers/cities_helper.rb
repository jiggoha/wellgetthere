module CitiesHelper

	def get_restaurant(client, city)
		client.spots(city.longitude, city.latitude, :types => 'restaurants')[0]
	end

	def get_entertainment(client, city)
		place = client.spots(city.longitude, city.latitude, :types=>['museum','art_gallery','campground','amusement_park','aquarium','zoo'])[0]
	end

	def get_hotel_information(city, date, duration)
		connection = Faraday.new('http://www.priceline.com') do |conn|
			conn.response :json, :content_type => 'application/json'
			conn.adapter Faraday.default_adapter
		end
		appended = '/api/hotelretail/listing/v3/' + city.latitude.to_s + ',' + city.longitude.to_s + '/' + date.to_s(:number) + '/' + (date+duration).to_s(:number) + '/1/1?sort=2'
		response = connection.get(appended)
		id = response.body["hotels"].keys[0]
		return "http://www.priceline.com/hotel/hotelOverviewGuide.do?propID=" + id.to_s, response.body["hotels"].first[1]["merchPrice"]
	end

	def get_coordinates(place)
		data = Geocoder.search(place)
		data.map{|i| {name: i.data["formatted_address"], latitude: i.data["geometry"]["location"]["lat"], longitude: i.data["geometry"]["location"]["lng"]}}
  end

	def getMapUrl (coordinates)
		center = Geocoder::Calculations.geographic_center(coordinates)
		urlString = "https://maps.googleapis.com/maps/api/staticmap?"
		urlString += "center=" + center[0].to_s + "," + center[1].to_s
		urlString += "&markers=color:red%7C" + center[0].to_s + "," + center[1].to_s
		
		coordinates.each do |x|
			urlString += "&markers=color:blue%7C" + x.gsub(' ','+')
		end

		urlString.chomp!(',')
		urlString += "&size=400x400&maptype=satellite"		
	end

	def find_destination(coordinates, num_results)
		center = Geocoder::Calculations.geographic_center(coordinates)
		distances = []
		counter = 0
		City.all.each do |city|
			distance = distance_between(center, [city.latitude, city.longitude])
			if !distance.nan?
				distances << {id: city.id, distance: distance}
			else
				counter += 1
			end
		end
		distances = distances.sort_by{|element| element[:distance]}
		first = distances.first
		City.find(first[:id])
		# distances.map{|id| City.find(id).city_state}
	end

	 def distance_between(point1, point2)

	  # convert degrees to radians
	  point1 = to_radians(point1)
	  point2 = to_radians(point2)

	  # compute deltas
	  dlat = point2[0] - point1[0]
	  dlon = point2[1] - point1[1]

	  a = (Math.sin(dlat / 2))**2 + Math.cos(point1[0]) *
	      (Math.sin(dlon / 2))**2 * Math.cos(point2[0])
	  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
	  c * 6371.0
	end

	def to_radians(*args)
      args = args.first if args.first.is_a?(Array)
      if args.size == 1
        args.first * (Math::PI / 180)
      else
        args.map{ |i| to_radians(i) }
      end
    end

end
