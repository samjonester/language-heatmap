require 'language_mapper/mapper/location_geocoder'

class USLocationFilterer
	def initialize(opts = {})
		@location_geocoder = opts[:location_geocoder] || LocationGeocoder.new
	end

	def filter_us_locations(all_locations)
		all_locations.map{ |location| @location_geocoder.geocode(location) }.select{ |location| location.country_code == 'US' }
	end
end
