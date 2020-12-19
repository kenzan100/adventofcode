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

puts calc(nums)
