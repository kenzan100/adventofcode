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

Bag = Struct.new(:color, :quantity)

def parse_object(desc)
  return if desc == 'no other bags'
  regex = %r{(?<num>\d) (?<col>.+) bags?}
  matched = desc.match(regex)
  Bag.new(matched[:col], matched[:num].to_i)
end

input = Loader.load(day: 7) #, override: 'day7testinput.txt')
lines = input.split("\n")

# reversed graph
def make_reversed_graph(lines)
  rev_graph = Hash.new { |h, k| h[k] = [] }

  lines.each do |line|
    parsed = parse_line(line)
    parsed[:tos].each do |to|
      rev_graph[to.color] << parsed[:from]
    end
  end

  rev_graph
end

def make_graph(lines)
  graph = Hash.new { |h, k| h[k] = [] }

  lines.each do |line|
    parsed = parse_line(line)
    parsed[:tos].each do |to|
      graph[parsed[:from]] << to
    end
  end

  graph
end

rev_graph = make_reversed_graph(lines)
graph = make_graph(lines)

KEYWORD = 'shiny gold'

def dfs(node, coefficient, sum, graph)
  sum += node.quantity * coefficient

  graph[node.color].each do |descendent|
    sum = dfs(descendent, node.quantity * coefficient, sum, graph)
  end

  sum
end


puts dfs(Bag.new(KEYWORD, 1), 1, 0, graph) - 1
