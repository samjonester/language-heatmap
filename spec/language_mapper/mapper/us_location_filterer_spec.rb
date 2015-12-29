require 'language_mapper/mapper/us_location_filterer'

describe USLocationFilterer do
	let(:location_finder) { double('LocationFinder') }

	subject { USLocationFilterer.new(location_finder: location_finder) }

	context "Should filter non us locations" do
		let(:all_locations) {[
			'town, not_us'
		]}
		let(:us_locations) {[]}
		let(:geolocation) { double('geocode', country_code: 'Not US') }

		it "Should equal us locations" do
			expect(location_finder).to receive(:geocode).with('town, not_us').and_return(geolocation)

				expect(subject.filter_us_locations(all_locations)).to eq(us_locations)
		end
	end

	context "Should filter us locations" do
		let(:all_locations) {[
			'city, us'
		]}
		let(:us_locations) {[ geolocation ]}
		let(:geolocation) { double('geocode', country_code: 'US') }

		it "Should equal us locations" do
			expect(location_finder).to receive(:geocode).with('city, us').and_return(geolocation)

				expect(subject.filter_us_locations(all_locations)).to eq(us_locations)
		end
	end
end
