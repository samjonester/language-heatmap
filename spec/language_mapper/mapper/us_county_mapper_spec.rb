require 'language_mapper/mapper/us_county_mapper'

describe USCountyMapper do
	let(:output_file_name) { Tempfile.new('foo').path }
	let(:counties) {{ 'county1': 2 }}

	let(:color_scaler) { double('ColorScaler') }
	let(:svg_mapper) { double('SVGMapper') }

	subject { USCountyMapper.new(output_file_name, color_scaler: color_scaler, svg_mapper: svg_mapper) }

	it "Should map counties" do
		expect(svg_mapper).to receive(:load_file!).with(output_file_name)

		expect(color_scaler).to receive(:create_scale!).with(counties)
		expect(color_scaler).to receive(:color_for).with(2).and_return(:red)
		expect(svg_mapper).to receive(:color_county!).with(:'county1', :red)

		expect(subject.map(counties)).to eq(output_file_name)
	end
end
