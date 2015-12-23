require 'language_mapper/location_finder/repo_lister'

describe RepoLister do
	let(:language) { 'piglatin' }
	let(:repo_list) {[
		{ full_name: 'bobs/diner' },
		{ full_name: 'xdd/cuddly-waffle' }
	]}

	let(:client) { double('Client') }
	let(:search_response) { double('search_response', items: [{ full_name: 'bobs/diner' }]) }
	let(:next_response_value) { double('next_response_value', items: [{ full_name: 'xdd/cuddly-waffle'  }]) }
	let(:next_response) { double('next_response', get: next_response_value) }
	let(:last_response) { double('last_response', rels: {next: next_response})  }
	let(:nil_last_response) { double('nil_last_response', rels: {})  }

	subject { RepoLister.new(client: client) }

	it "Should list repositories by language" do
		expect(client).to receive(:search_repos).with("language:#{language}").and_return(search_response)
		expect(client).to receive(:last_response).and_return(last_response, nil_last_response)

		expect(subject.find_repositories_for_language(language).force).to eq(repo_list)
	end
end
