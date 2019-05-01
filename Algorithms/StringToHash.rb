def string_to_hash str
	stack = 0
	key,value = "",""
	output_hash = {}
	i=1
	while (i<str.length-1)		
		if(key=="")
			key = str[i..str.length-1].split(":")[0]
			i+=key.length
			key = key.to_i unless key.match?(/[^\d\s]/)
		elsif (str[i]=="[")
			stack+=1
			value+=str[i]
		elsif str[i]=="]" && stack>0
			stack-=1
			value+=str[i]
		elsif (stack==0 && str[i]=="," )||(str[i]=="]" && i==str.length-2) 
			output_hash.store(key,value)
			key,value="",""
		elsif str[i]=="]"
			next
		else
			value+=str[i]
		end
		i+=1
	end
	return output_hash
end


puts string_to_hash "{key:[[value_1, value_2],[value_3, value4]], 5:10:00AM]}"