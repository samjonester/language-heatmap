require 'language_mapper/mapper/location_geocoder'

class USLocationFilterer
	def initialize(opts = {})
		@location_geocoder = opts[:location_geocoder] || LocationGeocoder.new
	end

	def is_us_location(geolocation)
		!geolocation.nil? && geolocation.country_code == 'US'
	end
end
