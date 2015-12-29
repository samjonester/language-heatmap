require 'language_mapper/mapper/countyfier'

describe Countyfier do
	let(:locations) {[ double('location', sub_country: 'My County') ]}
	let(:counties) {[ 'My' ]}

	it "Should map geolocations to counties" do
		expect(subject.countify(locations)).to eq(counties)
	end
end
