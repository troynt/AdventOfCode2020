
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/14
class DockingDatum
  def initialize(lines)
    @lines = lines
  end

  def apply_mask(num, mask_str)
    ret = ""

    num_binary = num.to_s(2).rjust(mask_str.length, "0")
    mask_str.chars.each_with_index do |bit, idx|
      case bit
      when "X"
        ret << num_binary[idx]
      when "1"
        ret << "1"
      when "0"
        ret << "0"
      end
    end

    ret.to_i(2)
  end

  def apply_mask2(num, mask_str)
    ret = ""

    num_binary = num.to_s(2).rjust(mask_str.length, "0")
    mask_str.chars.each_with_index do |bit, idx|
      case bit
      when "X"
        ret << "X"
      when "1"
        ret << "1"
      when "0"
        ret << num_binary[idx] # unchanged
      end
    end


    ret.chars
  end

  def create_nums(mask)
    a, *rest = mask

    if rest.length == 0
      case a
      when "1", "0"
        return [a]
      else
        return ["1", "0"]
      end
    end

    combos = create_nums(rest)


    case a
    when "1", "0"
      return combos.map do |x|
        a + x
      end

    when "X"
      ret = []
      combos.each do |x|
        ret << "1" + x
        ret << "0" + x
      end

      return ret
    end
  end

  def calc_part_one
    mask = ""
    mem = []

    @lines.each do |line|
      case line
      when /mask/
        _, mask_str = line.split(' = ')
        mask = mask_str
      when /mem/
        _, idx, num = line.match(/mem\[(\d+)\] = (\d+)/).to_a.map(&:to_i)
        mem[idx] = apply_mask(num, mask)
      end
    end

    mem.reject(&:nil?).sum
  end

  def calc_part_two
    mask = ""
    mem = {}

    @lines.each do |line|
      case line
      when /mask/
        _, mask_str = line.split(' = ')
        mask = mask_str
      when /mem/
        _, idx, num = line.match(/mem\[(\d+)\] = (\d+)/).to_a.map(&:to_i)

        create_nums(apply_mask2(idx, mask)).each do |addr|
          parsed_addr = addr.to_i(2)
          mem[parsed_addr] = num
        end
      end
    end

    mem.values.reject(&:nil?).sum
  end
end
