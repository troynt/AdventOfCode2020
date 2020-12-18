
require 'awesome_print'
require 'pry'

Passport = Struct.new(:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid, keyword_init: true) do

  def parsed_byr
    byr.to_i
  end

  def parsed_iyr
    iyr.to_i
  end

  def parsed_eyr
    eyr.to_i
  end

  def valid_height?
    h = hgt.to_i
    return false if h == 0
    if hgt.end_with?("cm")
      return h >= 150 && h <= 193
    elsif hgt.end_with?("in")
      return h >= 59 && h <= 76
    end
    false
  end

  def valid_hair?
    return false if hcl.nil?

    !!hcl.match(/\A#[a-f0-9]{6}\Z/)
  end

  def valid_eye?
    %w(amb blu brn gry grn hzl oth).include?(ecl)
  end

  def valid_pid?
    return false if pid.nil?

    !!pid.match(/\A[0-9]{9}\Z/)
  end

  def valid?
    parsed_byr >= 1920 && parsed_byr <= 2002 && parsed_iyr >= 2010 && parsed_iyr <= 2020 && parsed_eyr >= 2020 && parsed_eyr <= 2030 && valid_height? && valid_hair? && valid_eye? && valid_pid?
  end

end

# https://adventofcode.com/2020/day/4
class PassportProcessing
  def initialize(input)
    @passports = []

    cur_passport = []
    input.each do |line|
      if line.length == 0
        @passports.push(cur_passport)
        cur_passport = []
      else
        cur_passport.push(line)
      end
    end
    @passports.push(cur_passport)

    @passports.map! do |p|
      p.join(' ').split(' ').reduce({}) do |accum, attr|
        k, v = attr.split(':')
        accum[k] = v
        accum
      end
    end
  end

  def calc_part_one
    required_fields = %w(byr iyr eyr hgt hcl ecl pid)

    @passports.filter do |p|
      !p.values_at(*required_fields).any?(&:nil?)
    end.length
  end

  def calc_part_two
    @passports.filter do |attrs|
      p =  Passport.new(**attrs)
      p.valid?
    end.length
  end
end
