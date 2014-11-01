module CitiesHelper

	def get_coordinates(place)
		data = Geocoder.search(place)
		data.map{|i| {name: i.data["formatted_address"], latitude: i.data["geometry"]["location"]["lat"], longitude: i.data["geometry"]["location"]["lng"]}}
	end

	def find_destination(coordinates, num_results)
		center = Geocoder::Calculations.geographic_center(coordinates)
		distances = []
		City.all.each do |city|
			distance = distance_between(center, [city.latitude, city.longitude])
			if !distance.nan?
				distances << {id: city.id, distance: distance}
			else
				puts city.name
			end

		end
		distances = distances.sort_by{|element| element[:distance]}
		distances = distances[0..num_results-1].map{|i| i[:id] }
		distances.map{|id| City.find(id).city_state}
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
