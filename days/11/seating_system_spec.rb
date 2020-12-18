
require_relative 'seating_system'

describe 'SeatingSystem', :day11 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    SeatingSystem.new(lines)
  end

  it 'should be able to get adjacent tiles correctly' do
    ex = with_data('fixtures/example.txt')

    expect(ex.tile_at(Vector[-1,-1])).to eq(nil)
    expect(ex.adj_tiles_at(Vector[0,0]).length).to eq(3)
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(37)
  end


  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(2093)
  end

  xit 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(26)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(1862)
  end
end
