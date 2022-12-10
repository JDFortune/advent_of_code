
### PART 1 RULES
# how many trees are visible from the given arrangement
# a tree is visible if any all trees above left right or below it are lower than the tree height


# set visible trees to 0
# iterate over forest array (2nd row to 2nd to last row)
#   iterate over row (2nd tree to 2nd to last tree)
#     if all of the trees to the are lower than the current tree in any direction, increment visible trees by 1
# add the count of the first row, 2nd row and 2x the size of the forest to the visible trees variable



### PART 2 RULES
# Rules
#   part two count the number to trees that are visible from each tree location
#   count every trees tree visibility
#   if a tree is on the edge at lease one of its sides will be zero
#     scenic score is made by multiplying the visible trees in all four directions together

#     Questions:
#     Does a zero on any side cause the scenic score to be 0.
#       I will say no for now(remove zeros before calculating)
#     What if there is a smaller tree behind a taller tree but both are under your trees height?
#       I will say to count both for now.
#       If it turns out to be wrong, then do not count trees that are lower than the previous tree


# iterate through every tree
#   for each tree, find the number of trees that can be found in each direction
#     for the left
#       get the array of trees and count in reverse
#     increment count if tree is smaller than current
#       break and return count +1 if tree is same as current
#     for up
#       get all trees for every row top in the column reverse through
#         increment count if tree is smaller than current
#         break and return count +1 if tree is same as current
#     for right
#       get all trees to right
#         same
#     for down
#       get all in column below
#       same

# scenic score
# iterate through all the arrays of tree count
#     select only non zero values and multiply them together


# return highest scenic score





forest = []
File.readlines('input_8.txt', chomp: true).each do |row|
  forest << row
end

#### helper methods ####
def left(forest, row, col)
  forest[row][0...col].chars
end

def right(forest, row, col)
  forest[row][col + 1..].chars
end

def top(forest, row, col)
  forest[0...row].map {|r| r[col]}
end

def bottom(forest, row, col)
  forest[row+1..].map {|r| r[col]}
end


#### PART 1 ####
def check_trees(forest, row, col, current)
  left(forest, row, col).all? {|tree| tree < current} ||
  right(forest, row, col).all? {|tree| tree < current} ||
  top(forest, row, col).all? {|tree| tree < current} ||
  bottom(forest, row, col).all? {|tree| tree < current}
end


def visible_trees(forest)
  visible = ((forest.size * 2) - 4) + (forest[0].size * 2)
  (1...(forest.size - 1)).each do |row|
    (1...(forest[row].size - 1)).each do |col|
      current = forest[row][col]
      visible += 1 if check_trees(forest, row, col, current)
    end
  end
  visible
end

p visible_trees(forest)

#### PART 2 ####
def count(trees, current)
  counts = 0
  trees.each do |tree|
    counts += 1
    return counts if tree >= current
  end
  counts
end

def trees_seen(forest)
  forest.map.with_index do |trees_row, row|
    trees_row.chars.map.with_index do |current, col|
      trees_left = left(forest, row, col)
      trees_right = right(forest, row, col)
      trees_up = top(forest, row, col)
      trees_down = bottom(forest, row, col)
      [ count(trees_left.reverse, current),
        count(trees_right, current), 
        count(trees_up.reverse, current),
        count(trees_down, current) ]
    end
  end
end


def scenic_scores(trees_seen)
  trees_seen.map! do |trees_row|
    trees_row.map do |tree_view|
      tree_view.reduce(&:*)
    end.max
  end
end

trees_seen = trees_seen(forest)
p scenic_scores(trees_seen).max

