require 'geocoder'

class LocationGeocoder
	def initialize(opts = {})
		@geocoder = opts[:geocoder] || Geocoder
	end

	def geocode(location)
		@geocoder.search(location).first
	end
end
