require 'language_mapper/mapper/countyfier'

describe Countyfier do
	let(:geocoded_location) { double('location', sub_state: 'Random County', state_code: 'ST') }
	let(:county_name_with_state) { 'Random, ST' }
	
	it "Should map geolocations to counties" do
		expect(subject.countyfy(geocoded_location)).to eq(county_name_with_state)
	end
end
