require 'socket'

hostname = 'localhost'
port = 2000

socket = TCPSocket.open(hostname, port)
while line = socket.gets
  puts line.chop
end
s.close