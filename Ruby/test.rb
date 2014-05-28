#print "Whats your name? "
#name = gets.chomp
#print "Hello " + name
#print "Integer please: "
#user_num = Integer(gets.chomp)
#if user_num < 0
#  puts "You picked a negative integer!"
#elsif user_num > 0
#  puts "You picked a positive integer!"
#else
#  puts "You picked zero!"
#end
#http://status.github.com/api.json
require 'open-uri'
require "net/https"
require "uri"

response = Net::HTTP.get_response("http://status.github.com/api.json")
puts response.body 
