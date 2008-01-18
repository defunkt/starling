require 'rubygems'
require 'memcache'
require 'starling'
require 'benchmark'

Times = 40_000

server = TCPSocket.new('localhost', 22122)

Benchmark.bm do |x|
  x.report 'get' do
    Times.times do
      server.write "get dog:pound\r\n"
    end
  end
end
