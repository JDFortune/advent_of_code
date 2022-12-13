# monkey objects with attributes throwing items based on how worried you are about each item.

# monkey object
#   - starting_items => int value representing worry level
#   - operation => shows how the worry level changes as monkey inspects an item (new = old * x)
#   - test shows how the mnkey uses your worry level to decide where to throw next item
#   - if true show to monkey
#   - if false throw to other monkey


class Monkey
  attr_accessor :inspected, :name

  def initialize(name, items, op, test_div, true_monkey, false_monkey)
    @name = name
    @op = op
    @items = items
    @test_div = test_div
    @inspected = 0
    @true_monkey = true_monkey
    @false_monkey = false_monkey
  end

  def inspect_items
    items.map! do |old|
      self.inspected += 1
      new = (eval op)
      new.fdiv(3).round
    end
  end

  def toss_items
    items.dup.each do |item|
      to_monkey = ((item % test_div) == 0) ? true_monkey : false_monkey
      MONKEYS.find {|m| m.name == to_monkey}.add_item(items.shift)
    end
  end

  private

  attr_reader :items, :op, :test_div, :true_monkey, :false_monkey

  protected

  def add_item(item)
    items << item
  end
end

monkey0 = Monkey.new(0,[98, 97, 98, 55, 56, 72], 'old * 13', 11, 4, 7)

monkey1 = Monkey.new(1,[73, 99, 55, 54, 88, 50, 55], 'old + 4', 17, 2, 6)

monkey2 = Monkey.new(2, [67, 98], 'old * 11', 5, 6, 5)

monkey3 = Monkey.new(3, [82, 91, 92, 53, 99], 'old + 8', 13, 1, 2)

monkey4 = Monkey.new(4, [52, 62, 94, 96, 52, 87, 53, 60], 'old * old', 19, 3, 1)

monkey5 = Monkey.new(5, [94, 80, 84, 79], 'old + 5', 2, 7, 0)

monkey6 = Monkey.new(6, [89], 'old + 1', 3, 0, 5)

monkey7 = Monkey.new(7, [70, 59, 63], 'old + 3', 7, 4, 3)

MONKEYS = [monkey0, monkey1, monkey2, monkey3, monkey4, monkey5, monkey6, monkey7]

20.times do 
  MONKEYS.each do |monkey|
    monkey.inspect_items
    monkey.toss_items
  end
end

p MONKEYS.map(&:inspected).max(2).reduce(&:*)



