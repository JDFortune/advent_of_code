datastream = File.read('day_6.txt', chomp: true)

def time_it
  start = Time.now
  yield
  nd = Time.now
  nd - start
end

def buffer_marker(data, length)
  data.size.times do |idx|
    buffer_test = data[idx, length].chars
    return idx + length if buffer_test == buffer_test.uniq
  end
end


p time_it { p buffer_marker(datastream, 4)}
p time_it { p buffer_marker(datastream, 14)}


