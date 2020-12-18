
require_relative 'encoding_error'

describe 'EncodingError', :day9 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    EncodingError.new(lines)
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one(5)).to eq(127)
  end

  it 'should be running sum' do
    a = [1, 2, 3, 4]
    b = [1, 3, 6, 10]

    expect(b[2] - b[0]).to eq(5)
    expect(b[3] - b[1]).to eq(7) # 3rd + 4th
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(776203571)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two(5)).to eq(62)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(104800569)
  end
end
