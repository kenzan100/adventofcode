require 'pp'

RULES = {
  'byr' => -> (val) { val.to_i.between?(1920, 2002) },
  'iyr' => -> (val) { val.to_i.between?(2010, 2020) },
  'eyr' => -> (val) { val.to_i.between?(2020, 2030) },
  'hgt' => -> (val) {
    matched = %r{(\d*)(cm|in)}.match val
    next false if matched.nil?

    res = if matched[2] == 'cm'
      matched[1].to_i.between?(150, 193)
    elsif matched[2] == 'in'
      matched[1].to_i.between?(59, 76)
    else
      false
    end

    res
  },
  'hcl' => -> (val) {
    matched = %r{#([0-9|a-f]+)}.match val
    next false if matched.nil?

    res = (matched[1]&.size || 0) == 6

    res
  },
  'ecl' => -> (val) {
    res = %w[amb blu brn gry grn hzl oth].include? val
    res
  },
  'pid' => -> (val) {
    matched = %r{\d+}.match val
    next false if matched[0] != val
    next false if matched[0].size > 9

    res = val == ("%09d" % val.to_i)
    pp val if res == true
    res
  }
}

def valid?(key, value)
  return false if value.nil?

  RULES[key].call(value)
end

path = 'day4input.txt'
input = File.read(path)

chunks = input.split("\n\n")

documents = chunks.map do |chunk|
  document = chunk.split("\n").map { |line| line.split(" ") }.flatten
  document.reduce({}) do |hash, pair|
    key, value = pair.split(":")
    hash[key] = value
    hash
  end
end

cnt = 0
required = %w[byr iyr eyr hgt hcl ecl pid]
documents.each do |document|
  is_valid = required.all? do |key|
    valid?(key, document[key])
  end
  cnt += 1 if is_valid
end

puts cnt
