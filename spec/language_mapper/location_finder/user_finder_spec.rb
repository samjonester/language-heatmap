require 'language_mapper/location_finder/user_finder'

describe UserFinder do
	let(:usernames) {[ 'bobbycodesalot' ]}
	let(:user) {{ location: 'city' }}
	let(:locations) {[ 'city' ]}

	let(:client) { double('client') }

	subject { UserFinder.new(client: client) }

	it "Should return a list of locations given a list of users" do
		expect(client).to receive(:user).with('bobbycodesalot').and_return(user)

		expect(subject.get_locations_for_usernames(usernames)).to eq(locations)
	end
end
