require 'language_mapper/mapper/us_location_filterer'

describe USLocationFilterer do
	context "Should filter non us locations" do
		let(:geolocation) { double('geocode', country_code: 'Not US') }

		it "Should equal us locations" do
				expect(subject.is_us_location(geolocation)).to eq(false)
		end
	end

	context "Should filter us locations" do
		let(:geolocation) { double('geocode', country_code: 'US') }

		it "Should equal us locations" do
				expect(subject.is_us_location(geolocation)).to eq(true)
		end
	end
end
