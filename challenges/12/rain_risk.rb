
require 'awesome_print'
require 'pry'
require 'matrix'

# https://adventofcode.com/2020/day/12
class RainRisk

  attr_reader(
      :angle
  )

  DIRS = {
      "N" => Vector[0, 1],
      "E" => Vector[1, 0],
      "S" => Vector[0, -1],
      "W" => Vector[-1, 0]
  }

  def initialize(lines)
    @ins = lines.map do |line|
      cmd, *rest = line.chars
      [cmd, rest.join.to_i]
    end
    @waypoint = Vector[10, 1]
    @pos = Vector[0,0]
    @angle = 0
  end

  def to_rads(deg)
    deg * Math::PI / 180
  end

  def exec_cmd(cmd, amt)
    case cmd
    when "L"
      @angle += amt
    when "R"
      @angle -= amt
    when "F"
      rads = to_rads(@angle)
      x, y = @pos.to_a
      x += (amt * Math.cos(rads)).round
      y += (amt * Math.sin(rads)).round
      @pos = Vector[x, y]
    when "N", "E", "S", "W"
      @pos += DIRS[cmd] * amt
    else
      raise "Unknown command " + cmd
    end
  end

  def exec_cmd2(cmd, amt)
    case cmd
    when "L", "R"
      amt_rads = to_rads(amt)
      amt_rads *= -1 if cmd == "R"
      dx, dy = @waypoint.to_a
      radius = Math.sqrt(dx ** 2 + dy ** 2)

      rad = Math.atan2(dy, dx) + amt_rads
      @waypoint = radius * Vector[Math.cos(rad), Math.sin(rad)]
    when "F"
      @pos += @waypoint * amt
    when "N", "E", "S", "W"
      @waypoint += DIRS[cmd] * amt
    else
      raise "Unknown command " + cmd
    end
  end

  def calc_part_one
    @ins.each do |cmd, amt|
      exec_cmd(cmd, amt)
    end

    @pos.to_a.map(&:abs).sum.round
  end

  def calc_part_two
    @ins.each do |cmd, amt|
      exec_cmd2(cmd, amt)
    end

    @pos.to_a.map(&:abs).sum.round
  end
end

# bad guesses
# 1415
#
# answer is 521