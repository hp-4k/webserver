require 'socket'

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
	else  
	  client.print "HTTP/1.0 404 NOT FOUND\r\n\r\n"
	end
	client.close
end