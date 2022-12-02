#### PART 1 ####

ELF_LOSS_CHART = { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
ELF_TIE_CHART = {'A' => 'X', 'B' => 'Y', 'C' => 'Z'}
PLAYER_MOVES = ['X', 'Y', 'Z']

def elf_tie(elf, human); ELF_TIE_CHART[elf] == human; end
def elf_lose(elf, human); ELF_LOSS_CHART[elf] == human; end

def convert_input(str)
  rounds = str.split("\n")
  rounds.map { |round| round.split }
end

def evaluate_round(elf, human)
  score = PLAYER_MOVES.index(human) + 1
  if elf_lose(elf, human)
    score += 6
  elsif elf_tie(elf, human)
    score += 3
  end
  score
end

def my_score(rounds)
  rounds = convert_input(rounds)
  score = 0
  rounds.each do |elf, human|
    score += evaluate_round(elf, human)
  end
  score
end

#### PART 2 ####

WIN_CHART = { 'A' => 'B', 'B' => 'C', 'C' => 'A' }
LOSE_CHART = {'A' => 'C', 'B' => 'A', 'C' => 'B'}
MOVES = ['A', 'B', 'C']

def win(elf); MOVES.index(WIN_CHART[elf]) + 7; end
def lose(elf); MOVES.index(LOSE_CHART[elf]) + 1; end
def tie(elf); MOVES.index(elf) + 4; end

def convert_input(str)
  rounds = str.split("\n")
  rounds.map { |round| round.split }
end

def evaluate_round(elf, action)
  case action
  when 'X'
    lose(elf)
  when 'Y'
    tie(elf)
  when 'Z'
    win(elf)
  end
end

def my_score(rounds)
  rounds = convert_input(rounds)
  score = 0
  rounds.each do |elf, action|
    score += evaluate_round(elf, action)
  end
  score
end