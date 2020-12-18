
require 'awesome_print'
require 'pry'
require 'matrix'

ACTIVE = "#".to_sym
INACTIVE = ".".to_sym

DIRS = []
DIRS4 = []

(-1..1).each do |z|
  (-1..1).each do |y|
    (-1..1).each do |x|
      (-1..1).each do |w|
        next if x == 0 && y == 0 && z == 0 && w == 0
        DIRS4 << Vector[x,y,z,w]
      end

      next if x == 0 && y == 0 && z == 0
      DIRS << Vector[x,y,z,0]
    end
  end
end
DIRS.freeze
DIRS4.freeze

class Tile
  attr_reader(
    :state,
    :pos
  )

  attr_accessor(
    :next_state
  )

  def initialize(state, pos)
    @pos = pos
    @state = state
  end

  def active?
    state == ACTIVE
  end

  def key
    pos
  end

  def tick!
    @state = next_state if next_state
  end
end

# https://adventofcode.com/2020/day/17
class ConwayCube
  attr_reader(
    :width,
    :tiles
  )

  def initialize(lines)
    @width = lines.first.length
    @tiles = Hash.new do |h, k|
      Tile.new(INACTIVE, k)
    end
    lines.each_with_index do |row, y|
      row.chars.each_with_index do |state, x|
        pos = Vector[x,y,0,0]
        t = Tile.new(state.to_sym, pos)
        persist!(t) if t.active?
      end
    end
  end

  def find_neighbors_at(pos, dirs)
    dirs.map do |dir|
      tiles[pos + dir]
    end
  end

  def neighbors_at(pos, dirs, neighbor_cache)
    return neighbor_cache[pos] if neighbor_cache.has_key?(pos)

    neighbor_cache[pos] = find_neighbors_at(pos, dirs)
  end

  def persist!(tile)
    return if @tiles.has_key?(tile.key)

    @tiles[tile.key] = tile
  end

  def tick!
    tiles.each { |_,v| v.tick! }
  end

  def run!(cycles, dirs)
    neighbor_cache = {}
    cycles.times do
      # not the most efficient way to do this. Under time constraints though.
      tiles.map {|_, t| neighbors_at(t.pos, dirs, neighbor_cache) + [t] }.flatten.uniq.each do |t|
        neighbors = neighbors_at(t.pos, dirs, neighbor_cache)
        active_neighbors = neighbors.select(&:active?)
        active_neighbor_count = active_neighbors.length
        if t.active?
          t.next_state = (active_neighbor_count == 2 || active_neighbor_count == 3) ? ACTIVE : INACTIVE
        else
          t.next_state= active_neighbor_count == 3 ? ACTIVE : INACTIVE
        end
        persist!(t) if t.next_state == ACTIVE
      end
      tick!
      neighbor_cache = {}
    end
  end

  def calc_part_one
    run!(6, DIRS)
    tiles.values.select(&:active?).length
  end

  def calc_part_two
    run!(6, DIRS4)
    tiles.values.select(&:active?).length
  end
end
