require 'octokit'

class UserFinder

	def initialize(opts = {})
		@client = opts[:client] || Octokit::Client.new
	end

	def get_locations_for_usernames(usernames)
		usernames.map{ |username| @client.user(username) }.map{ |user| user[:location] }
	end
end
