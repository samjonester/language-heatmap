Feature: Create heatmap of a github language by number of users in location
	With a Github API Client
	Map repositories by language to their contributors
	And cluster by location
	Then place on US Map to create a heat map

	Scenario: Create Language Heatmap
		Given a Github API Client
		When I create a language heatmap for ruby
		Then the heatmap is awesome sauce 
