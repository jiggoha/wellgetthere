module CitiesHelper
	def find_destination(places, num_results)
		center = Geocoder::Calculations.geographic_center(places)
		binding.pry
		puts center
		distances = []
		City.all.each do |city|
			distance = Geocoder::Calculations.distance_between(center, [city.latitude, city.longitude])
			if !distance.nan?
				distances << {id: city.id, distance: distance}
			else
				puts city.name
			end

		end
		binding.pry
		distances = distances.sort_by{|element| element[:distance]}
		distances[0..num_results].map{|i| i[:id] }
	end
end
