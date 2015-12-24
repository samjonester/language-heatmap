require 'frequency_clusterer'

describe FrequencyClusterer do
	let(:input) {[ 'a', 'b', 'c', 'b', 'c', 'c' ]}
	let(:output) {{ a: 1, b: 2, c: 3 }}

	it "Should cluster things by their frequency" do
		expect(subject.cluster(input)).to eq(output)
	end
end
