require_relative '../helpers/loader.rb'

input = Loader.load(day: 13) # , override: 'day13testinput.txt')

now, bus_ids = input.split("\n")
now = now.to_i
bus_ids = bus_ids.split(",").select { |id| id != 'x' }.map(&:to_i)

def part1(now, bus_ids)
  min = Float::INFINITY
  min_id = nil

  bus_ids.each do |id|
    elapsed = now % id
    return [id, 0] if elapsed == 0

    n_more = id - elapsed
    min = [n_more, min].min
    if min == n_more
      min_id = id
    end
  end
  [min_id, min]
end

BusOp = Struct.new(:id, :offset, :time) do
  def time_offsetted
    id - offset
  end
end

_, bus_ops = input.split("\n")
bus_ops = bus_ops.split(",").each_with_object([]).with_index do |(num, arr), i|
  next if num == 'x'
  arr.push BusOp.new(num.to_i, i, 0)
end

def part2(bus_ops)
  dep = 0
  step_size = bus_ops[0].id

  bus_ops[1..-1].each do |bus_op|
    while (dep + bus_op.offset) % bus_op.id != 0
      pp [(dep + bus_op.offset), bus_op.id]
      dep += step_size
    end

    step_size *= bus_op.id
  end

  dep
end

pp part2(bus_ops)
