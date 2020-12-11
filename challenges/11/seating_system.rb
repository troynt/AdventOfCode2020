
require 'awesome_print'
require 'pry'
require 'matrix'

class Tile
  attr_accessor(
      :status,
      :next_status
  )

  def initialize(status)
    @status = status
  end

  def may_sit?
    status == "L"
  end

  def empty?
    status == "L" || floor?
  end

  def occupied?
    status == "#"
  end

  def floor?
    status == "."
  end

  # returns true if state changed
  def tick!
    unless @next_status.nil?
      @status = @next_status
      @next_status = nil
      return true
    end

    false
  end
end

# https://adventofcode.com/2020/day/11
class SeatingSystem
  DIRS = [
      Vector[0, -1],
      Vector[-1, -1],
      Vector[-1, 0],
      Vector[-1, 1],
      Vector[0, 1],
      Vector[1, 1],
      Vector[1, 0],
      Vector[1, -1]
  ].freeze

  def initialize(lines)
    @layout = lines.map { |row| row.chars.map { |c| Tile.new(c) }}

    @row_count = @layout.length
    @column_count = @layout[0].length
  end

  def calc_part_one
    loop do
      # print

      break unless run!
    end

    @layout.flatten.count(&:occupied?)
  end

  def calc_part_two
    loop do
      # print
      break unless run2!
    end

    @layout.flatten.count(&:occupied?)
  end


  def run!
    0.upto(@layout.length - 1).each do |row|
      0.upto(@layout[row].length - 1).each do |column|
        cur_pos = Vector[column, row]
        cur_tile = tile_at(cur_pos)
        adj_tiles = adj_tiles_at(cur_pos)

        if cur_tile.may_sit? && !adj_tiles.any?(&:occupied?)
          cur_tile.next_status = "#"
        end

        if cur_tile.occupied? && adj_tiles.count(&:occupied?) >= 4
          cur_tile.next_status= "L"
        end
      end
    end

    tick!
  end

  def run2!
    0.upto(@layout.length - 1).each do |row|
      0.upto(@layout[row].length - 1).each do |column|
        cur_pos = Vector[column, row]
        cur_tile = tile_at(cur_pos)
        adj_tiles = adj_visible_tiles_at(cur_pos)

        if cur_tile.may_sit? && !adj_tiles.any?(&:occupied?)
          cur_tile.next_status = "#"
        end

        if cur_tile.occupied? && adj_tiles.count(&:occupied?) >= 5
          cur_tile.next_status= "L"
        end
      end
    end

    tick!
  end

  def tile_at(pos)
    column, row = pos.to_a

    return nil if out_of_bounds?(pos)

    return @layout[row][column] unless @layout[row].nil?

    nil
  end

  def out_of_bounds?(pos)
    column, row = pos.to_a

    column < 0 || row < 0 || row >= @row_count || column >= @column_count
  end

  def adj_tiles_at(pos)
    DIRS.map do |v|
      tile_at(pos + v)
    end.filter { |x| !x.nil? }
  end

  def adj_visible_tiles_at(pos)
    DIRS.map do |v|
      found = nil
      cur_dir = pos
      loop do
        cur_dir += v
        break if out_of_bounds?(cur_dir)
        found = tile_at(cur_dir)
        break if !found.nil? && !found.floor?
      end

      found
    end.filter { |x| !x.nil? }
  end

  def print
    puts "~~~"
    @layout.each do |row|
      puts row.map(&:status).join
    end
    puts "~~~"
  end

  def tick!
    @layout.flatten.map(&:tick!).any? { |x| x }
  end
end
