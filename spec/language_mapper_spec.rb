require 'language_mapper'

describe LanguageMapper do
	let(:language) { 'piglatin' }
	let(:clustered_locations) {{ city: 42, town: 7 }}
  let(:output_file_name) { '/tmp/my_file.map' }

	let(:client) { double('Octokit::Client') }
	let(:location_finder) { double('LocationFinder') }
	let(:mapper) { double('Mapper') }

	subject { LanguageMapper.new(client: client, location_finder: location_finder, mapper: mapper) }

	it "Should map a language" do
		expect(location_finder).to receive(:cluster_locations_for_language).with(language).and_return(clustered_locations)
		expect(mapper).to receive(:map).with(clustered_locations).and_return(output_file_name)

		expect(subject.map_language(language)).to eq(output_file_name)
	end
end
