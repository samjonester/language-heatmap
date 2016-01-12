require 'geocoder'

class LocationGeocoder
	def initialize(opts = {})
		@geocoder = opts[:geocoder] || Geocoder
	end

	def geocode(location)
		sleep(1.0/5.0)
		@geocoder.search(location).first
	end
end
