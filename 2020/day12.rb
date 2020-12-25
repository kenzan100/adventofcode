require_relative '../helpers/loader.rb'

input = Loader.load(day: 12) #, override: 'day12testinput.txt')
instructions = input.split("\n")

Ship = Struct.new(:compass, :x, :y, :way_x, :way_y) do
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
    @ship = Ship.new(90, 0, 0, 10, 1)
  end

  def navigate
    @instructions.each do |line|
      cmd = parse(line)
      move(cmd)
      pp @ship
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
      @ship.way_y += cmd.num if cmd.symbol == 'N'
      @ship.way_y -= cmd.num if cmd.symbol == 'S'
      @ship.way_x += cmd.num if cmd.symbol == 'E'
      @ship.way_x -= cmd.num if cmd.symbol == 'W'
    when 'L', 'R'
      rotate_part2(cmd)
    when 'F'
      forward_part2(cmd)
    else
      raise 'move error'
    end
  end

  def rotate_part2(cmd)
    new_way_x, new_way_y = [@ship.way_x, @ship.way_y]

    case [cmd.symbol, cmd.num]
    in ['L', 90]
      new_way_x = @ship.way_y * -1
      new_way_y = @ship.way_x
    in ['R', 90]
      new_way_x = @ship.way_y
      new_way_y = @ship.way_x * -1
    in ['L', 270]
      new_way_x = @ship.way_y
      new_way_y = @ship.way_x * -1
    in ['R', 270]
      new_way_x = @ship.way_y * -1
      new_way_y = @ship.way_x
    in [_, 180]
      new_way_x = @ship.way_x * -1
      new_way_y = @ship.way_y * -1
    end

    @ship.way_x = new_way_x
    @ship.way_y = new_way_y
  end

  def rotate_part1(cmd)
    case cmd.symbol
    when 'L'
      @ship.compass -= cmd.num
    when 'R'
      @ship.compass += cmd.num
    end
    @ship.compass = @ship.compass % 360
  end

  def forward_part2(cmd)
    @ship.x += @ship.way_x * cmd.num
    @ship.y += @ship.way_y * cmd.num
  end

  def forward_part1(cmd)
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
