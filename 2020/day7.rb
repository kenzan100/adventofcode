require_relative '../helpers/loader'

def parse_line(line)
  # dotted black bags contain no other bags.
  # bright white bags contain 1 shiny gold bag.
  # muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  regex = %r{\A(?<from>.*) bags contain (?<to>.*)\.\Z}
  matched = line.match(regex)
  tos = matched[:to].split(", ").map { |desc| parse_object(desc) }.compact
  {
    from: matched[:from],
    tos: tos
  }
end

def parse_object(desc)
  return if desc == 'no other bags'
  regex = %r{(?<num>\d) (?<col>.+) bags?}
  matched = desc.match(regex)
  matched[:col]
end

input = Loader.load(day: 7) #, override: 'day7testinput.txt')
lines = input.split("\n")

# reversed graph
graph = Hash.new { |h, k| h[k] = [] }

lines.each do |line|
  parsed = parse_line(line)
  parsed[:tos].each do |to|
    graph[to] << parsed[:from]
  end
end

pp graph

# BFS
keyword = 'shiny gold'
queue = graph[keyword]
visited = { } # keyword => true }
cnt = 0

while !queue.empty?
  shifted = queue.shift
  cnt += 1 unless visited[shifted]

  graph[shifted].each do |candidate|
    next if visited[candidate]
    queue.push(candidate)
  end

  visited[shifted] = true
end

puts cnt
