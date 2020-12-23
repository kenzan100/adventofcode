require_relative '../helpers/loader.rb'

input = Loader.load(day: 9)
nums = input.split("\n").map(&:to_i)

window = nums[0..24].dup
idx = 25

while idx < nums.size
  pp idx
  num = nums[idx]
  valid = window.combination(2).find { |pair| pair.reduce(&:+) == num }

  unless valid
    pp window
    puts num
    break
  end
  window.shift
  window.push(num)
  idx += 1
end

def combination(n)
end
