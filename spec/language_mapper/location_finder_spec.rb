require 'language_mapper/location_finder'

describe LocationFinder do
	let(:language) { 'piglatin' }
	let(:clustered_locations) {{ city: 2, town: 1 }}
	let(:repo_list) {[
		{ contributor_url: 'http://url.com' },
		{ contributor_url: 'http://awesomesauce_peoples.com' }
	]}
	let(:user_list) {[ 'bobby', 'joe', 'anne' ]}
	let(:location_list) {[ 'city', 'town', 'city' ]}
	
	let(:repo_lister) { double('RepoLister') }
	let(:contributor_examiner) { double('ContributorExaminer') }
	let(:user_finder) { double('UserFinder') }
	let(:frequency_clusterer) { double('FrequencyClusterer') }

	subject { LocationFinder.new(repo_lister: repo_lister, contributor_examiner: contributor_examiner, user_finder: user_finder, frequency_clusterer: frequency_clusterer) }

	it "Should find clustered locations for a language" do
		expect(repo_lister).to receive(:find_repositories_for_language).with(language).and_return(repo_list)
		expect(contributor_examiner).to receive(:find_unique_contributors_for_repos).with(repo_list).and_return(user_list)
		expect(user_finder).to receive(:get_locations_for_usernames).with(user_list).and_return(location_list)
		expect(frequency_clusterer).to receive(:cluster).with(location_list).and_return(clustered_locations)

		expect(subject.cluster_locations_for_language(language)).to eq(clustered_locations)
	end
end
