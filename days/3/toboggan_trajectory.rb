
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/3
class TobogganTrajectory
  def initialize(map)
    @map = map
    @width = map[0].length
    @height = map.length
  end

  def is_tree?(x, y)
    @map[y][x % @width] === '#'
  end

  def calc_tree_count(dx, dy)
    x = 0
    y = 0
    tree_count = 0
    while y < @height - 1
      x += dx
      y += dy
      tree_count += 1 if is_tree?(x, y)
    end

    tree_count
  end

  def calc_part_one
    calc_tree_count(3, 1)
  end

  def calc_part_two
    result = 1


    [
        [1, 1],
        [3, 1],
        [5, 1],
        [7, 1],
        [1, 2]
    ].each do |dx, dy|
      result = result * calc_tree_count(dx, dy)
    end

    result
  end
end
