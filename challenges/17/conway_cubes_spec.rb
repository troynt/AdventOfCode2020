
require_relative 'conway_cubes'

describe 'ConwayCube', :day17 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    ConwayCube.new(lines)
  end

  it 'should be able to encode and decode pos' do
    ex = with_data('fixtures/example.txt')
    expect(ex.str_to_pos("1,2,3")).to eq(Vector[1,2,3])
    expect(ex.pos_to_str(Vector[1,2,3])).to eq("1,2,3")
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(112)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(313)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(848)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(2640)
  end
end
