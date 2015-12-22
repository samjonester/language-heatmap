require 'octokit'
require 'language_mapper'

Given(/^a Github API Client$/) do
	if File.exists?('private/creds.yml')
		creds = YAML.load_file('private/creds.yml') 
		@client = Octokit::Client.new(login: creds[:login], password: creds[:password])
	else
		fail "Please create the file private/creds.yml with the following format\nlogin: username\npassword: passwd"
	end
end

When(/^I create a language heatmap for (.*)$/) do |language|
	@output_file_name = LanguageMapper.new(client: client).map_language(language)
end

Then(/^the heatmap is awesome sauce$/) do
	puts @output_file_name
	expect(File.exists?(@output_file_name)).to be_true
end
