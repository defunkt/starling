require 'rubygems'
require 'memcache'
require 'starling'
require 'benchmark'

Times = 20_000

server = TCPSocket.new('localhost', 22122)

Benchmark.bm do |x|
  x.report 'get' do
    Times.times do
      server.write "get dog:pound\r\n"
    end
  end

#  x.report 'set' do
#    Times.times do
#      server.write "set dog 0 0 9\r\n\004\b\"\npound\r\n"
#    end
#  end
end
