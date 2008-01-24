require 'rubygems'
require 'memcached'
require 'starling'
require 'benchmark'

Times = 20_000

client = Memcached.new('127.0.0.1:22122')

Benchmark.bm do |x|
#  x.report 'get' do
#    Times.times do
#      begin
#        client.get 'dog'
#      rescue Memcached::NotFound
#        nil
#      end
#    end
#  end

  x.report 'set' do
    Times.times do
      client.set 'dog', 'pound'
    end
  end
end
