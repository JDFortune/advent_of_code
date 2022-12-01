def advent_1(cals_list)
  elves_cals = cals_list.split("\n\n")
  elves_cals.map! {|elf_cals| elf_cals.split("\n")}
  elves_cals.map! {|elf_cals| elf_cals.map(&:to_i).sum }
  elves_cals.max
end

def advent_2(cals_list)
  elves_cals = cals_list.split("\n\n")
  elves_cals.map! {|elf_cals| elf_cals.split("\n")}
  elves_cals.map! {|elf_cals| elf_cals.map(&:to_i).sum }
  elves_cals.max(3).sum
end