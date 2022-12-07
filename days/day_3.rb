### PART 1
VALUES = ('a'..'z').to_a + ('A'..'Z').to_a
packs = []
items = []

File.readlines('day_3_input1.txt').each do |pack|
  pack = pack.chomp
  size = pack.size / 2
  comp1 = pack[0...size]
  comp2 = pack[size..-1]
  packs << [comp1, comp2]
end

packs.each do |comp1, comp2|
  comp1.each_char do |item|
    break items << item if comp2.include?(item)
  end
end

p items.map! {|item| values.index(item) + 1 }.sum

### PART 2 ###
packs = []
badge = []
grouped_packs = []

File.readlines('day_3_input1.txt').each do |pack|
  packs << pack.chomp
end

until packs.empty?
  grouped_packs << packs.shift(3)
end

grouped_packs.each do |groups|
  groups[0].each_char do |chr|
    break badge << chr if groups.all? { |pack| pack.include?(chr) }
  end
end

p badge.map! {|item| values.index(item) + 1 }.sum