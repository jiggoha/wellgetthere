module CitiesHelper

	def get_coordinates(place)
		data = Geocoder.search(place)
		data.map{|i| {name: i.data["formatted_address"], latitude: i.data["geometry"]["location"]["lat"], longitude: i.data["geometry"]["location"]["lng"]}}
	end

	def find_destination(coordinates, num_results)
		center = Geocoder::Calculations.geographic_center(coordinates)
		distances = []
		City.all.each do |city|
			distance = Geocoder::Calculations.distance_between(center, [city.latitude, city.longitude])
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
end
