require 'pp'

input = nil
path = 'day1input.txt'
File.open(path) { |f| input = f.read }

nums = input.split("\n").map(&:to_i)

def calc(nums)
  table = {}
  nums.each do |n|
    if table[n]
      return n * table[n]
    end

    diff = 2020 - n
    table[diff] = n
  end
end


def calc2(nums)
  nums.each.with_index do |n, i|
    target = 2020 - n
    table = {}
    nums.each.with_index do |m, j|
      next if i == j
      if table[m]
        pp [n, m, table[m]]
        pp n + m + table[m]
        return n * m * table[m]
      end

      diff = target - m
      table[diff] = m
    end
  end
end

puts calc2(nums)
