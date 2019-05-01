require 'set'
def max_count str

	# # Solution 1
	# # run time O(n+k) where n is the size of string and k is the size of array after split
	# # gsub and split scans the string takes n time each so 2n plus the map of array will take k time where k is the size of the array 
	# zero_arr = (str.gsub(/^0*|0*$/, "").split("1")[1..])
	# return zero_arr ? zero_arr.map(&:length).max : 0

	# # Solution 2
	#  run time O(n) where n is the size of the string
	max = 0		
	count = 0
	flag = false
	str.each_char do |c|
		if !flag && c=="1"
			flag=true
		elsif flag && c=="1"
			max=count if count>max
			count=0
		elsif flag && c=="0"
			count+=1
		end
	end
	return max
end

puts max_count "10000000010000101000000001010101000010010000100100000110000000"
puts max_count "111111111"