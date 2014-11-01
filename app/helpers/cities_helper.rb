module CitiesHelper
	def find_destination(places, distance)
		center = Geocoder::Calculations.geographic_center(places)
		box = Geocoder::Calculations.bounding_box(center, distance)
		destinations = City.within_bounding_box(box)
		if destinations.empty?
			distance += 20
			find_destination(places, distance)
		elsif destinations.kind_of?(Array)
			destinations[0]
		else
			destinations
		end
	end
end
