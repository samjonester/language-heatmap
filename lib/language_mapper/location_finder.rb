require 'language_mapper/location_finder/repo_lister'
require 'language_mapper/location_finder/contributor_examiner'
require 'language_mapper/location_finder/user_finder'

class LocationFinder
	
	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
		@repo_lister = opts[:repo_lister] || RepoLister.new(client: @client)
		@contributor_examiner = opts[:contributor_examiner] || ContributorExaminer.new(client: @client)
		@user_finder = opts[:user_finder] || UserFinder.new(client: @client)
		@frequency_clusterer = opts[:frequency_clusterer] || FrequencyClusterer.new
	end

	def cluster_locations_for_language(language)
		repos = @repo_lister.find_repositories_for_language(language)
		users = @contributor_examiner.find_unique_contributors_for_repos(repos)
		locations = @user_finder.get_locations_for_usernames(users)
		@frequency_clusterer.cluster(locations)
	end
end
