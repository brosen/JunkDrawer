def encrypt str, ptAlphabet, cyAlphabet
	temp=Array.new(str.length)
	temp = str.split(//)
	temp.each_with_index {
	|val, index| 
		puts index.to_s + "=>" + val
		puts ptAlphabet.rindex(val)
		puts cyAlphabet.rindex(val)
		temp[index]=cyAlphabet.rindex(val)
	}
	#	puts index.to_s + "=>" + val
	#	puts ptAlphabet.rindex(val)
	#	puts cyAlphabet.rindex(val)
	#	temp[index]=cyAlphabet.rindex(val)
	#}
	
	
	
	#ptAlphabet.each_with_index {|val,index| str = str.gsub(val,cyAlphabet[index])}
	puts str	
	puts temp.join(",").gsub(",","")
end
def decrypt str, ptAlphabet, cyAlphabet
	cyAlphabet.each_with_index {|val,index| str = str.gsub(val,ptAlphabet[index])}
	
	puts str
end

method = ARGV[0].downcase
#gets.chomp
plainText = ARGV[1]
#gets.chomp

ptAlphabet = Array.new
ptAlphabet=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
cyAlphabet = Array.new
cyAlphabet = ["z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y"]


if(method=="e")
	encrypt plainText, ptAlphabet, cyAlphabet
elsif(method=="d")
	decrypt plainText, ptAlphabet, cyAlphabet
else
	puts "???"
end


