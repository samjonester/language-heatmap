require 'language_mapper/mapper/us_county_mapper/svg_mapper'

describe SVGMapper do

	let(:parser) { double('parser') }
	let(:doc) { double('doc') }
	let(:output_file_name) { 'my_file' }

	subject { SVGMapper.new(output_file_name, parser: parser) }

	before(:each) do
		file = double('file')
		expect(File).to receive(:read).with('assets/us_map.svg').and_return(file)
		expect(parser).to receive(:parse).with(file).and_return(doc)
		expect(doc).to receive(:dup).and_return(doc)
	end

	context "mapping" do
		let(:county) { 'County, ST' }
		let(:color) { 'red' }
		
		let(:styles) { double('styles') }
		let(:node) { double('node') }
		let(:style) { double('style') }

		it "Should map counties with color" do
			expect(doc).to receive(:at_xpath).with("//svg:path[@inkscape:label='Cuyahoga, OH']", 'svg': "http://www.w3.org/2000/svg", 'inkscape': "http://www.inkscape.org/namespaces/inkscape").and_return(node)
			expect(node).to receive(:styles).and_return(style)
			expect(style).to receive(:[]=).with('fill', color)
			expect(node).to receive(:styles=).with(style)

			subject.color_county!(county, color)
		end
	end

	context "writing" do
		let(:xml) { double('xml') }
		it "Should close the file" do
			expect(doc).to receive(:to_xml).and_return(xml)
			expect(File).to receive(:write).with(output_file_name, xml)

			expect(subject.close).to eq(output_file_name)
		end
	end
end
