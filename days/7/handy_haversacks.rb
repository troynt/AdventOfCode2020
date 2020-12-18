
require 'awesome_print'
require 'pry'
require 'ruby_structures'

# https://adventofcode.com/2020/day/7
class HandyHaversack
  def initialize(lines)
    @g = WeightedDirectedGraph.new
    @g2 = WeightedDirectedGraph.new
    lines.each do |line|
      parent_str, children_str = line.split(' contain ')
      children = []
      unless children_str.include?("no other")
        children = children_str.split(', ').map do |c| cleanup_name(c).split(' ', 2) end
      end
      parent_str = cleanup_name(parent_str)

      @g.add_vertex(parent_str)
      @g2.add_vertex(parent_str)
      children.each do |amt, c|
        w = amt.to_i
        @g.add_vertex(c)
        @g.create_edge(c, parent_str, w)

        @g2.add_vertex(c)
        @g2.create_edge(parent_str, c, w)
      end
    end
  end

  def cleanup_name(name)
    name.chomp('.').chomp("bags").chomp('bag').strip
  end

  def parent_count?(children, path)
    ret = 1
    children.each do |c, w|
      next if path.include?(c)
      path << c
      ret += parent_count?(@g[c], path)
    end

    ret
  end

  def calc_part_one
    parent_count?(@g["shiny gold"], []) - 1
  end

  def bag_count?(children)
    ret = 1
    children.each do |k, count|
      ret += bag_count?(@g2[k]) * count
    end

    ret
  end

  def calc_part_two
    bag_count?(@g2["shiny gold"]) - 1
  end
end
