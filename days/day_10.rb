# key terms
#  precise clock circuit
#   clock circuit ticks at a constant rate
#     each tick is called a cycle

# figure out the signal being sent by the cpu
#   - cpu has s single register 'X'
#   starts with the value 1

#   supports only 2 instructions
#     -addx V takes two cycles to complete. After two cycels, the `X` register is increased by the value V. (V can be negative)
#     - noop takes one cycle to complete. It has no other effect

instructions = File.read('input_10.txt').split("\n").map(&:split)

class Communicator
  LOG_CYCLE = [20, 60, 100, 140, 180, 220]
  LIT = '#'
  DARK = '.'
  def initialize
    @x_register = 1
    @cycle = 0
    @signal_strengths = []
    @test_at = 20
    @pixels = Array.new(6).map {Array.new(40)}
  end

  def addx(value)
    2.times do |n|
      mark_pixel
      self.cycle += 1
      send_signal if LOG_CYCLE.include?(cycle)
    end
    self.x_register += value
  end
  
  def noop
    mark_pixel
    self.cycle += 1
    send_signal if LOG_CYCLE.include?(cycle)
  end

  def sum_signals
    signal_strengths.sum
  end

  def to_s
    puts ''
    puts pixels.map(&:join)
    ''
  end

  private

  attr_accessor :cycle, :test_at, :x_register
  attr_reader :signal_strengths, :pixels

  def mark_pixel
    layer, node = [cycle / 40, cycle % 40]
    bs, es = [x_register - 1, x_register + 1]
    state = (bs..es) === node ? LIT : DARK
    pixels[layer][node] = state
  end

  def signal_strength
    cycle * x_register
  end

  def send_signal
    signal_strengths << signal_strength
    self.test_at += 40
  end
end

com = Communicator.new

instructions.each do |method, value|
  method = method.to_sym
  value = value.to_i unless value.nil?
  value ? com.send(method, value) : com.send(method)
end

p com.sum_signals
puts com