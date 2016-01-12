class RepoLister

	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
	end

	def find_repositories_for_language(language)
		Enumerator.new do |y|
			@client.search_repos("language:#{language}", per_page: 10000).items.each { |r| y << r }
			while response = @client.last_response.rels[:next]
				response.get.data.items.each { |r| y << r }
			end
		end.lazy
	end
end
