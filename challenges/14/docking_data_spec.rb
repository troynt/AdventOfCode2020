
require_relative 'docking_data'

describe 'DockingDatum', :day14 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    DockingDatum.new(lines)
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(165)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(11179633149677)
  end

  it 'should be able to create memory addresses' do
    ex = with_data('fixtures/example2.txt')
    expect(ex.create_nums("00000000000000000000000000000001X0XX".chars).map {|x| x.to_i(2) }.sort).to eq([16, 17, 18, 19, 24, 25, 26, 27])
  end

  it 'should be able to create memory addresses' do
    ex = with_data('fixtures/example2.txt')
    expect(ex.create_nums("000000000000000000000000000000X1101X".chars).map {|x| x.to_i(2) }.sort).to eq([26, 27, 58, 59])
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example2.txt')
    expect(ex.calc_part_two).to eq(208)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(4822600194774)
  end
end
