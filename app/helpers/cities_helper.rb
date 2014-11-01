module CitiesHelper
	def find_destination(places, num_results)
		center = Geocoder::Calculations.geographic_center(places)
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
