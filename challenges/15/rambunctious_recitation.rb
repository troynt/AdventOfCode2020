
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/15
class RambunctiousRecitation
  def initialize(lines)
    @nums = lines.first.split(',').map(&:to_i)
  end

  def calc_part_one(goal)
    when_spoken = Hash.new

    @nums.each_with_index { |val, idx| record_spoken(val, idx + 1, when_spoken) }

    round = @nums.length + 1
    last_spoken = @nums.last
    loop do
      found = when_spoken[last_spoken]
      if found.nil?
        last_spoken = 0
      else
        if found.length > 1
          a = found[-2]
          b = found[-1]
          last_spoken = b - a
        else
          last_spoken = 0
        end
      end

      record_spoken(last_spoken, round, when_spoken)

      break if round == goal

      round += 1
    end

    last_spoken
  end

  def calc_part_two
    calc_part_one(30_000_000)
  end

  def record_spoken(num, round, hash)
    # puts num
    if hash.key?(num)
      hash[num] << round
    else
      hash[num] = [round]
    end
  end
end
