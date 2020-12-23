# parse line into a command

# decision tree

# a: normal op
# b: flip op (if nop or jmp)
# (do b only if it hasn't been flipped)

# backtrack by resetting the state

require_relative '../helpers/loader'

Command = Struct.new(:instruction, :num_op)

input = Loader.load(day: 8, override: 'day8input.txt')
commands = input.split("\n").map do |line|
  cmd, num = line.split(" ")
  Command.new(cmd, num.to_i)
end

class Traverse
  def initialize(commands)
    @commands = commands
  end

  def dfs(idx, acc, visited, replaced)
    pp acc
    raise "SUCCESS #{acc}" if idx == @commands.size

    return if visited[idx]
    visited[idx] = true

    cmd = @commands[idx]
    new_idx, add = solve(cmd.instruction, idx, cmd.num_op)
    dfs(new_idx, acc + add, visited, replaced)

    if cmd.instruction != 'acc' && replaced == false
      new_idx, add = if cmd.instruction == 'nop'
                  solve('jmp', idx, cmd.num_op)
                else
                  solve('nop', idx, cmd.num_op)
                end

      dfs(new_idx, acc + add, visited, true)
    end
  end

  def solve(instruction, idx, num_op)
    case instruction
    when 'nop'
      [idx + 1, 0]
    when 'jmp'
      [idx + num_op, 0]
    when 'acc'
      [idx + 1, num_op]
    end
  end
end

Traverse.new(commands).dfs(0, 0, {}, false)
