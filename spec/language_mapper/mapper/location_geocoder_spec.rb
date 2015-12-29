require 'language_mapper/mapper/location_geocoder'

describe LocationGeocoder do
	let(:city) { 'city, us' }
	let(:location) { double('location') }

	let(:geocoder) { double('geocoder') }

	subject { LocationGeocoder.new(geocoder: geocoder) }

	it "Should geocode a location" do
		expect(geocoder).to receive(:search).with('city, us').and_return([location])
		expect(subject.geocode(city)).to eq(location)
	end
end
