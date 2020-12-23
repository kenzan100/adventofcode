require_relative '../helpers/loader.rb'

input = Loader.load(day: 9) #, override: 'day9testinput.txt')
nums = input.split("\n").map(&:to_i)

def part1(nums)
  window = nums[0..24].dup
  idx = 25

  while idx < nums.size
    num = nums[idx]
    valid = window.combination(2).find { |pair| pair.reduce(&:+) == num }

    unless valid
      puts num
      return num
    end
    window.shift
    window.push(num)
    idx += 1
  end
end

def part2(nums, target)
  head = 0
  tail = 1

  while head < nums.size
    while nums[head..tail].reduce(&:+) <= target
      return [head, tail] if nums[head..tail].reduce(&:+) == target
      tail += 1
    end

    while nums[head..tail].reduce(&:+) >= target
      return [head, tail] if nums[head..tail].reduce(&:+) == target
      head += 1
    end
  end
end

head, tail = part2(nums, part1(nums))
puts nums[head..tail].reduce(&:+)
puts nums[head..tail].max + nums[head..tail].min
