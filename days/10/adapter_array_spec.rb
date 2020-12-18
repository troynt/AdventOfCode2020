
require_relative 'adapter_array'

describe 'AdapterArray', :day10 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    AdapterArray.new(lines)
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(220)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(3034)
  end

  it 'should be able to handle small example data for part two' do
    ex = with_data('fixtures/small_example.txt')
    expect(ex.calc_part_two).to eq(8)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(19208)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(259172170858496)
  end
end
