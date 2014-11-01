class City < ActiveRecord::Base
	geocoded_by :city_state
	after_validation :geocode

	def city_state
		[name, state].join(', ')
	end
end
