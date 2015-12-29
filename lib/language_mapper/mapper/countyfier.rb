class Countyfier
	def countify(locations)
		locations.map{ |location| location.sub_country.gsub(" County", "")	}
	end
end
