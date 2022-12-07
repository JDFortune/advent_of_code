# # command-line problems

# # lines starting with $ are commands
# # cd for change directory
# #   x for move in x being the name of the directory
# #   .. for move out
# #   / for move to top level
# # ls for list all current directories (prints out all the files and directores immediately contained by the current directory)
# #   - 123 abs means that the current directory contains a file named abs with size 123
# #   - dir xyz means that the current director contains a directory named xyz

# #   determine total size of each directory ( sum of sizes of contained files)

# #   find all of the directories with total size no more than 100_000
# #   - calculate the sum of their total sizes. (process can count files more than once if nested directory and parent are both considered in sums)


# # multi-dimensional hash
# # parsing data
# # go through each line
# #   if line starts with $ it's a command

# input = File.read('input_7.txt').split("\n")

# pp input

# problem
# Given a string of commands and file names, parse the data to create the directory structure with contained files. Sum up the total of directories with a size less than 100_000.

# Rules
#   Explicit
#     If a both a nested directorys sum and its parent directorys sum (which includes the nested directory sum as a part of it) are both less than 100_000, the nested directory ends up getting counted twice (or even more if the parent directory is additionally a child of another directory with a combined sum < 100_000)
#     `$`l signifies a command
#     `dir` signifies a directory
#     `num letter` format is a file

# Data
# input - string
# intermediate  multi-dimensional hash
# output - integer sum of all files 

# Algorithm
# iterate over each line of the input
# if line starts with $
#   if command is cd
#     change directory to following dir()
#       if (directory name) move into directory name
#       if .. move up one level
#       if / move to outer hash
#   if command is ls
#     list all files and directories in current()
#   if command is 


# Treat this like OOP

# Directories can hold files
#     -can sum their files 
=begin
current_dir = nil
idx = 0
while idx < commands.size
  line = commands[idx]
  case line[1]
  when 'cd'
    current_dir = change_directories(all_directories, line[2])
    idx += 1
  when 'ls'
    idx += 1
    until line[idx][0] == '$'
      line = commands[idx]
      if number?(line[0])
        current_dir.children << DataFile.new(line[0], line[1])
      elsif line[idx][0] == 'dir'
        current_dir.children << Directory.new(line[1], current_dir)
      end
      idx += 1
    end
  end
end


def directory_exist?(all_directories, name)
  !!all_directories.find {|dir| dir.name == name}
end

def change_directories(all_dir, flag, current_dir)
  case flag
  when '/'
    if directory_exist?(all_directories,  )
end
=end

class Directory
  attr_reader :children, :parent, :name

  def initialize(name, parent = nil)
    @parent = parent
    @name = name
    @children = [] 
  end

  def size
    total = 0
    children.each do |obj|
      total += obj.size
    end
    total
  end

  def file_size
    children.select {|child| child.is_a? DataFile}.map(&:size).sum
  end
end

class DataFile
  attr_reader :size, :name

  def initialize(size, name)
    @size = size.to_i
    @name = name
  end
end

def number?(str)
  str.match?(/[0-9]/)
end

commands = File.read('input_7.txt').split("\n").map(&:split)

all_dir = []
all_dir << root = Directory.new('/')
current = root

#### Logic for sorting through commands #######
idx = 1
while idx < commands.size
  line = commands[idx]
  if line[0] == '$'
    if line[1] == 'cd'
      filename = line[2]
      case filename
      when '/'
        current = root
      when '..'
        current = current.parent
      else
        current = current.children.find {|dir| dir.name == filename}
      end
    end
  elsif number?(line[0])
    new_file = DataFile.new(line[0], line[1])
    current.children << new_file
  elsif line[0] == 'dir'
    new_dir = Directory.new(line[1], current)
    current.children << new_dir
    all_dir << new_dir
  end
  idx += 1
end
#######################################################

TOTAL_DISK_SPACE = 70_000_000
UPDATE_SIZE = 30_000_000

### PART 1 ###
all_dir.map(&:size).select {|size| size < 100_000 }.sum

used_space = all_dir.map(&:file_size).sum
free_space = TOTAL_DISK_SPACE - used_space
space_to_free_up = UPDATE_SIZE - free_space

### PART 2 ###
all_dir.map(&:size).select {|size| size > space_to_free_up }.min



