
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/13
class ShuttleSearch
  attr_reader(
      :buses
  )
  def initialize(lines)
    @earliest = lines.first.to_i
    @buses = lines.last.split(',').map(&:to_i)

    @buses_with_index = {}
    @buses.each_with_index do |id, idx|
      next if id == 0
      @buses_with_index[id] = idx
    end
  end

  def calc_part_one
    time = @earliest
    loop do
      found = @buses.find { |b| b != 0 && time % b == 0 }
      if found
        return (time - @earliest) * found
      end
      time += 1
    end
  end

  def good_time?(time, delta_idx)
    @buses_with_index.map do |id,idx|
      (time - (delta_idx - idx)) % id == 0
    end.all? {|x| x == true }
  end

  def found_buses(time, delta_idx)
    @buses_with_index.select do |id,idx|
      (time - (delta_idx - idx)) % id == 0
    end
  end

  def calc_part_two
    time = 0

    inc = @buses_with_index.keys.min

    lcm_group = []

    loop do
      if time < @earliest
        time += inc
        next
      end

      buses_found = found_buses(time, 0)
      if buses_found.length > lcm_group.length
        inc = buses_found.keys.reduce(1, :lcm)
      end

      done = good_time?(time, 0)

      if done && time >= @earliest
        return time
      end
      time += inc

    end
  end

  def slow_calc_part_two
    time = 0

    inc = @buses_with_index.keys.max
    delta_idx = @buses_with_index[inc]

    loop do
      if time < @earliest
        time += inc
        next
      end

      done = good_time?(time, delta_idx)

      if done && time >= @earliest
        return time - delta_idx
      end
      time += inc

      ap time if time % 1000000 == 0
    end
  end
end
