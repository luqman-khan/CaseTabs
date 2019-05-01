class Sample
	def initialize h
		@input_hash = h
		@input_hash.keys.each do |key|
			self.class.send(:define_method, key) do
				return @input_hash[key]
			end
		end
	end
end

h= {"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 100}
c = Sample.new(h)
puts c.this == [1,2,3,4,5,6]
puts c.that == ['here', 'there', 'everywhere']
puts c.other == 100
