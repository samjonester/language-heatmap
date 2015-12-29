class USLocationFilterer
	def initialize(opts = {})
		@location_finder = opts[:location_finder] || LocationFinder.new
	end

	def filter_us_locations(all_locations)
		all_locations.map{ |location| @location_finder.geocode(location) }.select{ |location| location.country_code == 'US' }
	end
end
