require 'language_mapper/mapper'

describe Mapper do
	let(:output_file_name) { Tempfile.new('foo').path }
	let(:clustered_locations) {{ 'city': 2, 'town': 3, 'non_us': 4 }}
	let(:us_locations) {{ 'city': 2, 'town': 3 }}
	let(:counties) {{ 'county1': 2, 'county2': 3 }}

	let(:us_location_filterer) { double('USLocationFilterer') }
	let(:countyfier) { double('Countyfier') }
	let(:us_county_mapper) { double('USCountyMapper') }

	subject { Mapper.new(output_file_name, us_location_filterer: us_location_filterer, countyfier: countyfier, us_county_mapper: us_county_mapper) }

	it "Should map a cluster of locations onto a US map" do
		expect(us_location_filterer).to receive(:filter_us_locations).with(clustered_locations).and_return(us_locations)
		expect(countyfier).to receive(:countyfy).with(us_locations).and_return(counties)
		expect(us_county_mapper).to receive(:map).with(counties).and_return(output_file_name)

		expect(subject.map(clustered_locations)).to eq(output_file_name)
	end
end
