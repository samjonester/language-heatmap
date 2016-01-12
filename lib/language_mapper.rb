require 'octokit'
require 'language_mapper/location_finder'
require 'language_mapper/mapper'

class LanguageMapper
	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
		@location_finder = opts[:location_finder] || LocationFinder.new(client: @client)
		@mapper = opts[:mapper] || Mapper.new('output.svg', client: @client)
	end

	def map_language(language)
		clustered_locations = @location_finder.cluster_locations_for_language(language)
		@mapper.map(clustered_locations)
	end
end
