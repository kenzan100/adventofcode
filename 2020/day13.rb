require_relative '../helpers/loader.rb'

input = Loader.load(day: 13) #, override: 'day13testinput.txt')

now, bus_ids = input.split("\n")
now = now.to_i
bus_ids = bus_ids.split(",").select { |id| id != 'x' }.map(&:to_i)

pp now, bus_ids

def main(now, bus_ids)
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

x, y = main(now, bus_ids)
puts x * y
