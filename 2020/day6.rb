require_relative '../helpers/loader'

input = Loader.load(day: 6)

groups = input.split("\n\n").map do |group|
  group.split("\n").map do |line|
    line.split("")
  end
end

pp groups[0..2]

sum = 0
offset = 97 #ascii code offset for 'a'

groups.each do |group|
  bucket = ('a'..'z').to_a.map { 0}
  group.each do |person|
    person.each do |yes|
      idx = yes.ord - offset
      bucket[idx] += 1
    end
  end
  sum += bucket.count { |cnt| cnt == group.size }
end

puts sum
