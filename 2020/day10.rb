require_relative '../helpers/loader.rb'

input = Loader.load(day: 10) #, override: 'day10testinput2.txt')
@nums = input.split("\n").map(&:to_i).sort

def solve_part1(nums)
  base = 0
  idx = 0
  dist = Hash.new(0)

  while idx < nums.size
    diff = nums[idx] - base
    dist[diff] += 1
    base = nums[idx]
    idx += 1
  end

  dist[3] += 1

  pp dist
  pp dist[1] * dist[3]
end

@nums.unshift(0)
@num_hash = @nums.each_with_object({}).with_index do |(num, hash), i|
  hash[num] = i
end

def dp(idx)
  return @memo[idx] if @memo[idx]

  num = @nums[idx]

  sum = (1..3).reduce(0) do |sum, diff|
    next sum unless @num_hash[num - diff]
    sum += dp(@num_hash[num - diff])
  end

  @memo[idx] = sum
  sum
end

@memo = { 0 => 1 }
dp(@nums.size - 1)
pp @nums
pp @memo
