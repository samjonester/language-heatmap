require 'language_mapper/mapper/us_county_mapper/color_scaler'

describe ColorScaler do
	let(:freqs) {{ 'one': 1, 'two': 30 }}

	it "Should create a scale for a frequency map" do
		subject.create_scale!(freqs)

		expect(subject.color_for(1)).to eq(:white)
		expect(subject.color_for(10)).to eq(:white)
		expect(subject.color_for(15)).to eq(:yellow)
		expect(subject.color_for(20)).to eq(:yellow)
		expect(subject.color_for(25)).to eq(:green)
		expect(subject.color_for(30)).to eq(:green)
	end
end
