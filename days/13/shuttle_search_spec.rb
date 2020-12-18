
require_relative 'shuttle_search'

describe 'ShuttleSearch', :day13 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    ShuttleSearch.new(lines)
  end

  it 'should be able to load buses' do
    ex = with_data('fixtures/example.txt')
    expect(ex.buses).to eq([7, 13, 0, 0, 59, 0, 31, 19])
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(295)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(222)
  end

  it 'should be able to detect good time' do
    ex = with_data('fixtures/example.txt')
    expect(ex.good_time?(1068785, 4)).to eq(true)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(1068781)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(408270049879073)
  end
end
