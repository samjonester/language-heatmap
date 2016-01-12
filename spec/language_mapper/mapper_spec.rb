require 'language_mapper/mapper'

describe Mapper do
	let(:output_file_name) { Tempfile.new('foo').path }
	let(:clustered_locations) {{ 'city': 2, 'non_us': 4 }}
	let(:counties) {{ 'County' => 2 }}

	let(:geocoded_city) { double('city') }
	let(:geocoded_city_non_us) { double('non_us') }

	let(:geocoder) { double('geocoder') }
	let(:us_location_filterer) { double('location_filterer') }
	let(:countyfier) { double('countyfier') }
	let(:us_county_mapper) { double('us_county_mapper') }

	subject { Mapper.new(output_file_name, geocoder: geocoder, us_location_filterer: us_location_filterer, countyfier: countyfier, us_county_mapper: us_county_mapper) }

	it "Should map a cluster of locations onto a US map" do
		expect(geocoder).to receive(:geocode).with(:'city').and_return(geocoded_city)
		expect(geocoder).to receive(:geocode).with(:'non_us').and_return(geocoded_city_non_us)

		expect(us_location_filterer).to receive(:is_us_location).with(geocoded_city).and_return(true)
		expect(us_location_filterer).to receive(:is_us_location).with(geocoded_city_non_us).and_return(false)

		expect(countyfier).to receive(:countyfy).with(geocoded_city).and_return('County')

		expect(us_county_mapper).to receive(:map).with(counties).and_return(output_file_name)

		expect(subject.map(clustered_locations)).to eq(output_file_name)
	end
end
