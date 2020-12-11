
require 'awesome_print'
require 'pry'
require 'active_support/core_ext/array'

# https://adventofcode.com/2020/day/10
class AdapterArray
  def initialize(lines)
    @adapters = lines.map(&:to_i).sort

    @memory = {}
    if @adapters.uniq.length != @adapters.length
      raise "probably doesn't work unless adapters are unique"
    end
  end

  def calculate(adapters)
    deltas = []
    last_adapter = 0
    adapters.each do |adapter|
      dt = adapter - last_adapter
      if dt > 3
        raise "fail"
      end
      deltas << dt
      last_adapter = adapter
    end
    deltas << 3 # my device's built-in adapter

    deltas.filter { |x| x == 1 }.length * deltas.filter { |x| x == 3 }.length
  end

  def calc_part_one
    calculate(@adapters)
  end

  def calc_part_two
    count_paths(@adapters, 0, @adapters.max + 3)
  end

  def count_paths(adapters, start, goal)
    k = [adapters, start]

    @memory[k] ||= begin
      paths = 0

      if goal - start <= 3
        return paths + 1
      end

      if adapters.length == 0
        return paths
      end

      new_start, *rest_adapters = adapters

      if new_start - start <= 3
        paths += count_paths(rest_adapters, new_start, goal)
      end

      paths += count_paths(rest_adapters, start, goal)

      paths
    end
  end
end
