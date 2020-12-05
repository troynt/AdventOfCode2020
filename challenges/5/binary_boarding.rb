
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/5
class BinaryBoarding
  def initialize(seats)
    @seats = seats
  end

  def self.decode_seat(seat)
    rows = (0..127).to_a
    columns = (0..7).to_a
    seat.chars.each do |c|
      case c
      when "B"
        rows.slice!(0,rows.length/2)
      when "F"
        rows.slice!(rows.length/2,rows.length)
      when "L"
        columns.slice!(columns.length/2,columns.length)
      when "R"
        columns.slice!(0,columns.length/2)
      end
    end
    rows.first * 8 + columns.first
  end

  def calc_part_one
    @seats.map do |seat|
      self.class.decode_seat(seat)
    end.max
  end

  def calc_part_two
    seat_ids = Set.new(@seats.map do |seat|
      self.class.decode_seat(seat)
    end)

    min, max = seat_ids.minmax
    (min..max).find do |sid|
      !seat_ids.include?(sid) && seat_ids.include?(sid - 1) && seat_ids.include?(sid + 1)
    end
  end
end
