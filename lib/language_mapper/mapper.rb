require 'language_mapper/mapper/us_location_filterer'
require 'language_mapper/mapper/countyfier'
require 'language_mapper/mapper/us_county_mapper'

class Mapper

	def initialize(output_file_name, opts = {})
		@file_name = output_file_name
		@geocoder = opts[:geocoder] || LocationGeocoder.new
		@us_location_filterer = opts[:us_location_filterer] || USLocationFilterer.new
		@countyfier = opts[:countyfier] || Countyfier.new
		@us_county_mapper = opts[:us_county_mapper] || USCountyMapper.new(@file_name)
	end

	def map(clustered_locations)
		clustered_counties = clustered_locations.each_with_object({}) do |(location, freq), acc|
			geocoded_location = @geocoder.geocode(location)
			if @us_location_filterer.is_us_location(geocoded_location)
				county_name = @countyfier.countyfy(geocoded_location)
				acc[county_name] = freq
			end
		end

		@us_county_mapper.map(clustered_counties)
	end
end
