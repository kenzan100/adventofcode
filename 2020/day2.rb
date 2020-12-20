require 'pp'

def valid1?(password, min, max, target)
  password.count(target).between?(min, max)
end

def valid2?(password, i, j, target)
  one = password[i-1] == target
  two = password[j-1] == target

  [one, two].count { |cond| cond == true } == 1
end

path = 'day2input.txt'
input = File.read(path)

lines = input.split("\n")
cnt = 0
lines.each do |line|
  minmax, target, password = line.split(" ")
  min, max = minmax.split("-").map(&:to_i)
  target.sub!(':', '')

  cnt += 1 if valid2?(password, min, max, target)
end

puts cnt
