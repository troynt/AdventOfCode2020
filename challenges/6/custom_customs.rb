
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/6
class CustomCustom
  def initialize(input)
    @groups = []

    cur_group = []
    input.each do |line|
      if line.length == 0
        @groups.push(cur_group)
        cur_group = []
      else
        cur_group.push(line)
      end
    end
    @groups.push(cur_group)
  end

  def letter_counts(word)
    word.chars.reduce({}) do |acc, c|
      acc[c] = acc[c].nil? ? 1 : acc[c] + 1
      acc
    end
  end

  def calc_part_one
    @groups.map do |group|
      letter_counts(group.join('')).keys.length
    end.sum
  end

  def calc_part_two
    @groups.map do |group|
      party_size = group.length
      letter_counts(group.join('')).filter do |k,v|
        v == party_size
      end.keys.length
    end.sum
  end
end
