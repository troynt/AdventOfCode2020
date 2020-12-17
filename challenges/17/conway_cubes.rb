
require 'awesome_print'
require 'pry'
require 'matrix'

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
    state == "#"
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
      Tile.new(".", k)
    end
    lines.each_with_index do |row, y|
      row.chars.each_with_index do |state, x|
        pos = Vector[x,y,0,0]
        t = Tile.new(state, pos)
        @tiles[t.key] = t
      end
    end

    @dirs = []
    (-1..1).each do |z|
      (-1..1).each do |y|
        (-1..1).each do |x|
          next if x == 0 && y == 0 && z == 0
          @dirs << Vector[x,y,z,0]
        end
      end
    end

    @dirs4 = []
    (-1..1).each do |z|
      (-1..1).each do |y|
        (-1..1).each do |x|
          (-1..1).each do |w|
            next if x == 0 && y == 0 && z == 0 && w == 0
            @dirs4 << Vector[x,y,z,w]
          end
        end
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
    @tiles[tile.key] = tile unless @tiles.has_key?(tile.key) # ensure it is persisted
  end

  def tick!
    tiles.each { |_,v| v.tick! }
  end

  def run!(cycles, dirs)
    neighbor_cache = {}
    cycles.times do
      tiles.map {|_, t| neighbors_at(t.pos, dirs, neighbor_cache) + [t] }.flatten.uniq.each do |t|
        neighbors = neighbors_at(t.pos, dirs, neighbor_cache)
        active_neighbors = neighbors.select(&:active?)
        if t.active?
          t.next_state = (active_neighbors.length == 2 || active_neighbors.length == 3) ? "#" : "."
        else
          t.next_state= active_neighbors.length == 3 ? "#" : "."
        end
        persist!(t)
      end
      tick!
      neighbor_cache = {}
    end
  end

  def calc_part_one
    run!(6, @dirs)
    tiles.values.select(&:active?).length
  end

  def calc_part_two
    run!(6, @dirs4)
    tiles.values.select(&:active?).length
  end
end
