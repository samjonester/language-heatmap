class RepoLister

	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
	end

	def find_repositories_for_language(language)
		Enumerator.new do |y|
			@client.search_repos("language:#{language}").items.each { |r| y << r }
			while response = @client.last_response.rels[:next]
				response.get.items.each { |r| y << r }
			end
		end.lazy
	end
end
