require 'pp'

class Loader
  def self.load(day:, override: nil)
    path = override || "day#{day}input.txt"
    File.read(path)
  end
end
