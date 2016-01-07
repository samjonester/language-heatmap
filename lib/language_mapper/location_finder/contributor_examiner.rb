class ContributorExaminer
	
	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
	end

	def find_unique_contributors_for_repos(repos)
		repos.flat_map do |repo|
			@client.contributors(repo[:full_name], per_page: 10000).map{ |c| c[:login] }
		end.to_set
	end
end
