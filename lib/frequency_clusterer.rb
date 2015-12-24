class FrequencyClusterer
	def cluster(things)
		things.each_with_object(Hash.new(0)) { |thing, hash| hash[thing.to_sym] += 1 }
	end
end
