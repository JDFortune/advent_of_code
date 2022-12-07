# nested arrays of stacks of crates (stack outer array elements, crates are nested array elements)

# stacks = [
#             ['R', 'G', 'H', 'Q', 'S', 'B' ,'T', 'N'],
#             ['H', 'S', 'F', 'D', 'P', 'Z', 'J'],
#             ['Z', 'H', 'V'],
#             ['M', 'Z', 'J', 'F', 'G', 'H'],
#             ['T', 'Z', 'C', 'D', 'L', 'M', 'S', 'R'],
#             ['M', 'T', 'W', 'V', 'H', 'Z', 'J'],
#             ['T', 'F', 'P', 'L', 'Z'],
#             ['Q', 'V', 'W', 'S'],
#             ['W', 'H', 'L', 'M', 'T', 'D', 'N', 'C']
# ]



commands = []
stacks = Array.new(9).map{Array.new}


def build_stack(line, stacks)
  temp = []
  line = line.chars
  idx = 1
  until idx > line.size
    temp << line[idx]
    idx += 4
  end
  temp.each_with_index {|crate, idx| stacks[idx] << crate unless crate.strip.empty?}
end

File.readlines('day_5.txt', chomp: true).each do |line|
  unless line.empty?
    if line.start_with?('[')
      build_stack(line, stacks)
    elsif line.start_with?('m')
      commands << line.split(/[^0-9]/).reject(&:empty?).map(&:to_i)
    end
  end
end

stacks.map!(&:reverse)

### PART 1 ###
def crate_mover_9000(commands, stacks)
  stacks = stacks.map(&:dup)
  commands.each do |boxes, frm_stk, to_stk|
    frm_stk -= 1
    to_stk -= 1
    boxes.times { stacks[to_stk] << stacks[frm_stk].pop }
  end
  stacks.map {|stk| stk.last }.join
end

p crate_mover_9000(commands, stacks)
### PART 2 ###
def crate_mover_9001(commands, stacks)
  stacks = stacks.map(&:dup)
  commands.each do |boxes, frm_stk, to_stk|
    frm_stk -= 1
    to_stk -= 1
    stacks[to_stk] += stacks[frm_stk].pop(boxes)
  end
  stacks.map {|stk| stk.last }.join
end
p crate_mover_9001(commands, stacks)

# create the array of 9 stacks (Array with 9 nested arrays)
# get each line into 3 number values
# iterat over each line (num_crates, from_stk, to_stk)
#   for num_crates times
#     move top crate from end of from_stk to end of to_stk
