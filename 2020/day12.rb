require_relative '../helpers/loader.rb'

input = Loader.load(day: 12) #, override: 'day12testinput.txt')
instructions = input.split("\n")

Ship = Struct.new(:compass, :x, :y) do
  def facing
    case self.compass
    when 0
      :north
    when 90
      :east
    when 180
      :south
    when 270
      :west
    else
      raise "facing error #{self}"
    end
  end

  def manhattan_distance
    x.abs + y.abs
  end
end

Cmd = Struct.new(:symbol, :num)

class Instruction
  def initialize(instructions)
    @instructions = instructions
    @ship = Ship.new(90, 0, 0)
  end

  def navigate
    @instructions.each do |line|
      cmd = parse(line)
      move(cmd)
    end
    @ship
  end

  def parse(line)
    cmd = Cmd.new
    cmd.symbol = line[0]
    cmd.num = line[1..-1].to_i
    cmd
  end

  def move(cmd)
    case cmd.symbol
    when 'N', 'S', 'E', 'W'
      @ship.y += cmd.num if cmd.symbol == 'N'
      @ship.y -= cmd.num if cmd.symbol == 'S'
      @ship.x += cmd.num if cmd.symbol == 'E'
      @ship.x -= cmd.num if cmd.symbol == 'W'
    when 'L', 'R'
      rotate(cmd)
    when 'F'
      forward(cmd)
    else
      raise 'move error'
    end
  end

  def rotate(cmd)
    case cmd.symbol
    when 'L'
      @ship.compass -= cmd.num
    when 'R'
      @ship.compass += cmd.num
    end
    @ship.compass = @ship.compass % 360
  end

  def forward(cmd)
    case @ship.facing
    when :east
      @ship.x += cmd.num
    when :west
      @ship.x -= cmd.num
    when :north
      @ship.y += cmd.num
    when :south
      @ship.y -= cmd.num
    else
      raise 'forward error'
    end
  end
end

ship = Instruction.new(instructions).navigate
pp ship
pp ship.manhattan_distance
