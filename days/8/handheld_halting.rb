
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/8
class HandheldHalting
  def initialize(lines)
    @prog = lines.map do |line|
      ins, dt = line.split(' ')
      [ins.to_sym, dt.to_i]
    end
  end

  def run!(prog)
    pt = 0
    acc = 0
    seen = Set.new
    while pt < prog.length
      if seen.include?(pt)
        raise StandardError.new(acc)
      end
      seen.add(pt)
      ins, dt = prog[pt]
      case ins
      when :jmp
        pt += dt
      when :acc
        acc += dt
        pt += 1
      when :nop
        pt += 1
      else
        raise "unknown instruction " + ins
      end
    end

    acc
  end

  def calc_part_one
    run!(@prog)
  rescue => e
    e.message.to_i
  end

  def calc_part_two
    @prog.each_with_index do |line, i|
      cur_ins, _ = line
      if cur_ins != :jmp && cur_ins != :nop
        next
      end

      tmp = @prog.map(&:dup)
      tmp[i][0] = cur_ins == :jmp ? :nop : :jmp

      begin
        acc = run!(tmp)
        return acc
      rescue
        next
      end
    end
  end
end
