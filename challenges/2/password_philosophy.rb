
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/2
class PasswordPhilosophy
  def initialize(lines)
    @lines = lines.map do |line|
      policy, password = line.split(': ')
    end
  end

  def letter_counts(word)
    word.chars.each_with_object(Hash.new(0)) do |c, h|
      h[c] += 1
    end
  end

  def calc_part_one
    @lines.filter do |policy, pass|
      counts = letter_counts(pass)
      min_max, letter = policy.split(' ')
      min, max = min_max.split('-').map(&:to_i)

      !counts[letter].nil? && counts[letter] >= min && counts[letter] <= max
    end.length
  end

  def calc_part_two
    @lines.filter do |policy, pass|
      positions, letter = policy.split(' ')
      first, second = positions.split('-').map(&:to_i)

      (pass[first - 1] == letter) ^ (pass[second - 1] == letter)
    end.length
  end
end
