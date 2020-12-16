
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/15
class RambunctiousRecitation
  def initialize(lines)
    @nums = lines.first.split(',').map(&:to_i)
  end

  def calc_part_one(goal)
    when_spoken = Hash.new

    @nums.each_with_index { |val, idx| when_spoken[val] = idx + 1 }

    spoken = @nums.last
    (@nums.length + 1).upto(goal).each do |round|
      last_spoken = spoken
      found = when_spoken[spoken]
      spoken = found.nil? ? 0 : round - 1 - found
      when_spoken[last_spoken] = round - 1
    end

    spoken
  end

  def calc_part_two
    calc_part_one(30_000_000)
  end
end
