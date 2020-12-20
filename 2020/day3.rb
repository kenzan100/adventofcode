require 'pp'

path = 'day3input.txt'
input = File.read(path)
lines = input.split("\n")

def calc(lines, right_co, down_co)
  width = lines[0].length
  cnt = 0

  lines.each.with_index do |line, i|

    next if i == 0
    next if (i % down_co) != 0

    idx = ((i / down_co) * right_co) % width
    cell = line[idx]
    cnt += 1 if cell == '#'
  end

  cnt
end

ans = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
].reduce(0) do |sum, (r, d)|
  x = calc(lines, r, d)
  puts x
  if sum == 0
    x
  else
    sum *= x
  end
end

puts ans
