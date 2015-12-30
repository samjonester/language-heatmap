require 'language_mapper/mapper/us_county_mapper/color_scaler'

class USCountyMapper
	def initialize(output_file_name, opts = {})
		@output_file_name = output_file_name
		@color_scaler = opts[:color_scaler] || ColorScaler.new
		@svg_mapper = opts[:svg_mapper] || SVGMapper.new
		@svg_mapper.load_file!(@output_file_name)
	end

	def map(counties)
		@color_scaler.create_scale!(counties)
		counties.each do |county, count|
			@svg_mapper.color_county!(county, @color_scaler.color_for(count))
		end
		@output_file_name
	end
end
