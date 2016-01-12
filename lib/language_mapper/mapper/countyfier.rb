class Countyfier

	def countyfy(location)
		county_name = location.sub_state.gsub(" County", "")
		state = location.state_code
		"#{county_name}, #{state}"
	end
end
