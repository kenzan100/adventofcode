require_relative '../helpers/loader.rb'

input = Loader.load(day: 8) #, override: 'day7testinput.txt')
lines = input.split("\n")

Command = Struct.new(:instruction, :num_op)

commands = lines.map do |line|
  instruction, num_op = line.split(" ")
  Command.new(instruction, num_op.to_i)
end

cur_idx = 0
visited = Hash.new(0)
acc = 0

while visited[cur_idx] < 1
  cmd = commands[cur_idx]
  visited[cur_idx] += 1

  case cmd.instruction
  when 'acc'
    acc += cmd.num_op
    cur_idx += 1
  when 'jmp'
    cur_idx += cmd.num_op
  when 'nop'
    cur_idx += 1
  else
    raise "#{cmd}"
  end
end

puts acc
