require 'socket'
require 'json'

server = TCPServer.open(2000)
loop do
	client = server.accept
	header = ''
	while line = client.gets
	  header += line
	  break if line == "\r\n"
	end
	puts "REQUEST HEADER:\n#{header}"
	if header =~ /GET/ && header =~ /\/index.html/
      client.print "HTTP/1.0 200 OK \r\n\r\n"
      client.print File.read("index.html")
	elsif header =~ /POST/ && header =~ /\/thanks.html/
		# find the length of body
		content_length = /Content-Length:\s+(\d+)/.match(header)[1].to_i
		# read body and convert from JSON to hash
		body = client.read(content_length)
		params = JSON.parse(body)
		# prepare response body
		response_body = File.read("thanks.html").
			gsub!("<%= yield %>", "<li>Name: #{params["viking"]["name"]}</li><li>Email: #{params["viking"]["email"]}</li>")
		# send the response
		client.print "HTTP/1.0 200 OK\r\n\r\n"
		client.print response_body			
	else  
	  client.print "HTTP/1.0 404 NOT FOUND\r\n\r\n"
	end
	client.close
end