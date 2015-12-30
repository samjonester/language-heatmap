class ColorScaler
	def create_scale!(frequencies)
		@max = frequencies.values.max
		@mid_third = @max * 2/3.0
		@low_third = @max / 3.0
	end

	def color_for(num)
		case num
		when 0..@low_third
			:white
		when @low_third..@mid_third
			:yellow
		when @mid_third..@max
			:green
		end
	end
end
