section_pairs = []

File.readlines('day_4.txt').each do |line|
  line = line.chomp.split(',')
          .map! {|list| list.split('-')}
          .map {|st, nd| (st.to_i..nd.to_i)}

  section_pairs << line
end

#### PART 1 ####
def count_full_overlap(section_pairs)
  section_pairs.count do |range1, range2|
    range1.all? { |sec| range2.include?(sec) } ||
    range2.all? { |sec| range1.include?(sec) }
  end
end

#### PART 2 ####
def count_any_overlap(section_pairs)
  section_pairs.count do |range1, range2|
    range1.any? { |sec| range2.include?(sec) }
  end
end

p count_full_overlap(section_pairs)
p count_any_overlap(section_pairs)