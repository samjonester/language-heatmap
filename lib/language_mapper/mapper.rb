require 'language_mapper/mapper/us_location_filterer'
require 'language_mapper/mapper/countyfier'
require 'language_mapper/mapper/us_county_mapper'

class Mapper

	def initialize(output_file_name, opts = {})
		@file_name = output_file_name
		@us_location_filterer = opts[:us_location_filterer] || USLocationFilterer.new
		@countyfier = opts[:countyfier] || Countyfier.new
		@us_county_mapper = opts[:us_county_mapper] || USCountyMapper.new(@file_name)
	end

	def map(clustered_locations)
		us_locations = @us_location_filterer.filter_us_locations(clustered_locations)
		counties = @countyfier.countyfy(us_locations)
		@us_county_mapper.map(counties)
	end
end
