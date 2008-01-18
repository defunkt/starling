threads = []

5.times do
  threads << Thread.new { puts `ruby speed/speed_test.rb` }
end

threads.map { |t| t.join }
