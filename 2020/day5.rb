require_relative '../helpers/loader.rb'

def b_search(arr, low, high, chars)
  if chars.empty?
    raise if low != high
    return arr[low]
  end

  clue = chars.shift
  mid = (high + low) / 2

  if %w[F L].include? clue # lower
    b_search(arr, low, mid, chars)
  elsif %w[B R].include? clue # higher
    b_search(arr, mid+1, high, chars)
  else
    raise
  end
end

input = Loader.load(day: 5)
lines = input.split("\n")

matrix = 128.times.map { |r| 8.times.map { |c| [r, c] } }

lines.each do |line|
  row_num = b_search(128.times.to_a, 0, 127, line[0..6].split(''))
  col_num = b_search(8.times.to_a, 0, 7, line[7..-1].split(''))
  pp [row_num, col_num]
  matrix[row_num][col_num] = 'X'
end

pp matrix
