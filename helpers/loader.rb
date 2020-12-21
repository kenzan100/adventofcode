require 'pp'

class Loader
  def self.load(day:)
    path = "day#{day}input.txt"
    File.read(path)
  end
end
