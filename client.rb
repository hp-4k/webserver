require 'socket'

hostname = 'localhost'
port = 2000

socket = TCPSocket.open(hostname, port)
socket.puts "aaaa\r\n\r\n"
while line = socket.gets
  puts line.chop
end
socket.close