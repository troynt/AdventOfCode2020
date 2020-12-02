
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/1
class ReportRepair
  def initialize(nums)
    @nums = nums
  end

  def calc_part_one
    s = Set.new(@nums)

    found = s.find do |n|
      s.include?(2020 - n)
    end

    found * (2020 - found)
  end

  def calc_part_two

    found = @nums.combination(3).find do |combo|
      combo.sum == 2020
    end

    found.inject(:*)
  end
end
