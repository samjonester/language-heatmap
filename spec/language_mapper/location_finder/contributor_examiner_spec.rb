require 'language_mapper/location_finder/contributor_examiner'

describe ContributorExaminer do
	let(:repos) {[
		{full_name: 'my/repo'}	
	]}
	let(:contributors_list) {[
		{login: 'bobbycodesalot'},
		{login: 'johndoe'}
	]}
	let(:contributors_logins) {Set.new([ 'bobbycodesalot', 'johndoe' ])}

	let(:client) { double('client') }
		
	subject { ContributorExaminer.new(client: client) }

	it "Should find unique contributors for repos" do
		expect(client).to receive(:contributors).with('my/repo', per_page: 10000).and_return(contributors_list)

		expect(subject.find_unique_contributors_for_repos(repos)).to eq(contributors_logins)
	end
end
