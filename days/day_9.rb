# modeling a rope physics
# imagine rope with knots at each end
#   knots as a head and tale of rope
#   rule: if the head is moved far enough away from the tail, the tail is pulled towards the head
#   use planck lengths to model positions as knots on a two-dimensinoal grid
#   following a hypothetical series of motions (puzzle input) for the head, you can determine how the tail will move.
#   Due to planck lengths, the rope must be quite shorts ( they head 'H' and tail 'T' must always be touching (diagonally, adjacent, even overlapping all count as touching))
#   - If the head is ever two steps directly up, down, left, or right from the tail, the tail must move one step in that direction so it remains close enough.
#   - If the head and tail aren't touching and aren't in the same row or column, the Tail will move diagonally 

#   Assuming the head and tail start in the same position, 
# need plank length 
#   plank_length = Math.sqrt((h * G) / (c ** 3))

# if the sum of Heads row and column is ever 2 more than the sum of the Tails row and column 
#   move the Tail to be next to the head
#   - if the 

# Maybe create a hash with the Head and Tail position at 0 for y and 0 for x

head_moves = File.read('input_9.txt').split("\n").map(&:split)
knot = {x: 0, y:0}
head = knot.dup
tail = knot.dup

def move_knot(knot, direction)
  case direction
  when 'L' then knot[:x] -= 1
  when 'R' then knot[:x] += 1
  when 'U' then knot[:y] += 1
  when 'D' then knot[:y] -= 1
  end
end

def mark_space(positions, knot)
  positions << [knot[:x], knot[:y]]
end

def move_tail(head, tail, tail_positions)
  if head[:y] == tail[:y] &&  head[:x] != tail[:x]
    tail_dir = head[:x] > tail[:x] ? 'R' : 'L'

    if (head[:x] - tail[:x]).abs > 1
      move_knot(tail, tail_dir)
      mark_space(tail_positions, tail)
    end

  elsif head[:x] == tail[:x] &&  head[:y] != tail[:y]
    tail_dir = head[:y] > tail[:y] ? 'U' : 'D'

    if (head[:y] - tail[:y]).abs > 1
      move_knot(tail, tail_dir)
      mark_space(tail_positions, tail)
    end

  elsif head[:x] != tail[:x] && head[:y] != tail[:y]
    vert_dir = head[:y] > tail[:y] ? 'U' : 'D'
    horz_dir = head[:x] > tail[:x] ? 'R' : 'L'

    if ((head[:y] - tail[:y]).abs > 1 || (head[:x] - tail[:x]).abs > 1)
      move_knot(tail, vert_dir)
      move_knot(tail, horz_dir)
      mark_space(tail_positions, tail)
    end
  end
end
### PART 1 ###

tail_positions = []
mark_space(tail_positions, tail)

head_moves.each do |dir, steps|
  steps = steps.to_i
  steps.times do
    move_knot(head, dir)

    move_tail(head, tail, tail_positions)
  end
end

p tail_positions.uniq.size

### PART 2 ###

knots = []
10.times { knots << knot.dup}
knots_positions = []
10.times { knots_positions << [knot.dup]}


head_moves.each do |dir, steps|
  steps.to_i.times do
    move_knot(knots[0], dir)
    lead, follow = [0, 1]

    until follow == knots.size
      move_tail(knots[lead], knots[follow], knots_positions[follow])
      lead += 1
      follow += 1
    end
  end
end

p knots_positions.last.uniq.size







