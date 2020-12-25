require_relative '../helpers/loader.rb'

input = Loader.load(day: 11) # , override: 'day11testinput.txt')

matrix = input.split("\n").map do |line|
  line.split("")
end

# transition = matrix.size.times.map { matrix[0].size.times.map { } }
# pp transition

class SeatsLifeGame
  attr_reader :matrix
  attr_accessor :transform_memo

  def initialize(matrix)
    @matrix = matrix
    @transform_memo = {} # [x, y] key, next state value
  end

  def main
    i = 0
    while true
      check(i)

      break if transform_memo.empty?
      apply
      self.transform_memo = {}
      i += 1
    end
  end

  def check(i)
    matrix.size.times do |row|
      matrix[0].size.times do |col|
        next_state = solve_part2(row, col)
        if next_state != matrix[row][col]
          key = [row, col]
          transform_memo[key] = next_state
        end
      end
    end
  end

  def apply
    transform_memo.each do |(row, col), val|
      matrix[row][col] = val
    end
  end

  def solve_part2(row, col)
    occupied_cnt = %w(upleft up upright left right downleft down downright).reduce(0) do |sum, direction|
      binary = peek(row, col, direction)
      sum += binary
      sum
    end

    cell = matrix[row][col]
    if cell == 'L'
      return '#' if occupied_cnt.zero?
    elsif cell == '#'
      return 'L' if occupied_cnt >= 5
    end

    cell
  end

  # return 1 if first seen is occupied
  def peek(row, col, direction)
    x, y = [row, col]
    x, y = peek_apply(x, y, direction)
    return 0 unless valid_boundary?(x, y)

    begin
      cell = matrix[x][y]
      return 1 if cell == '#'
      return 0 if cell == 'L'
      x, y = peek_apply(x, y, direction)
    end while valid_boundary?(x, y)

    0
  end

  def peek_apply(x, y, direction)
    case direction
    when 'upleft'
      x -= 1
      y -= 1
    when 'up'
      x -= 1
    when 'upright'
      x -= 1
      y += 1
    when 'left'
      y -= 1
    when 'right'
      y += 1
    when 'downleft'
      x += 1
      y -= 1
    when 'down'
      x += 1
    when 'downright'
      x += 1
      y += 1
    end
    [x, y]
  end

  def valid_boundary?(x, y)
    x.between?(0, matrix.size-1) &&
      y.between?(0, matrix[0].size-1)
  end

  def solve_part1(row, col)
    seats_to_check = [
      [row-1, col-1],
      [row-1, col],
      [row-1, col+1],
      [row, col-1],
      [row, col+1],
      [row+1, col-1],
      [row+1, col],
      [row+1, col+1]
    ].select do |x, y|
      valid_boundary?(x, y)
    end.map do |x, y|
      matrix[x][y]
    end

    cell = matrix[row][col]
    if cell == 'L'
      return '#' if seats_to_check.none? { |val| val == '#' }
    elsif cell == '#'
      return 'L' if seats_to_check.count { |val| val == '#' } >= 4
    end

    cell
  end
end

SeatsLifeGame.new(matrix).main
cnt = 0
matrix.size.times do |row|
  matrix[0].size.times do |col|
    cnt += 1 if matrix[row][col] == '#'
  end
end
pp cnt
