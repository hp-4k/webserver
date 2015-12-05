require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = "/index.html"

socket = TCPSocket.open(host, port)

puts "Which request do you want to send?"
puts "1) GET"
puts "2) POST"
user_input = gets.chomp

case user_input
when "1"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
when "2"
	puts "Let's pretend we are registering a viking for a raid."
	print "Please enter the vikings name: "
	name = gets.chomp
	print "Please enter the vikings email: "
	email = gets.chomp
	params = {viking: {name: name, email: email}}
	request =  "POST /thanks.html HTTP/1.0\r\n"
	request << "Content-Length: #{params.to_json.length}\r\n"
	request << "\r\n"
	request << params.to_json
else
	puts "It is not a valid choice!"
	exit
end
 
socket.print request
response = socket.read

headers, body = response.split("\r\n\r\n")
puts headers
puts body