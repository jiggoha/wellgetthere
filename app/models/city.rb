class City < ActiveRecord::Base
	def city_state
		[name, state].join(', ')
	end
end
