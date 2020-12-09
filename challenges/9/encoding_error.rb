
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/9
class EncodingError
  def initialize(lines)
    @nums = lines.map(&:to_i)
    calc_running_sum!
  end

  def calc_part_one(preamble_length = 25)
    @nums.each_with_index do |cur, idx|
      next if idx < preamble_length

      cur_preamble = @nums.slice((idx - preamble_length)..idx)

      found = cur_preamble.combination(2).find do |a,b|
        cur == a + b
      end

      if found.nil?
        return cur
      end
    end

    raise "Unable to solve part one."
  end

  def calc_running_sum!
    sum = 0
    @running_sum = @nums.map { |x| sum += x }
  end

  def calc_part_two(preamble_length = 25)
    invalid_num = calc_part_one(preamble_length)

    stop_idx = @nums.length - 1

    0.upto(stop_idx).each do |start_idx|
      (start_idx + 1).upto(stop_idx).each do |end_idx|
        cur_sum = @running_sum[end_idx] - @running_sum[start_idx - 1]
        break if cur_sum > invalid_num

        if cur_sum == invalid_num
          return @nums.slice(start_idx..end_idx).minmax.sum
        end
      end
    end

    raise "Unable to solve part two."
  end
end