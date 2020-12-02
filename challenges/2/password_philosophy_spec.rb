
require_relative 'password_philosophy'

describe 'PasswordPhilosophy', :day2 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    nums = f.readlines.map(&:strip)

    PasswordPhilosophy.new(nums)
  end

  it 'should be able to count letters' do
    a = PasswordPhilosophy.new([])
    expect(a.letter_counts('aaabb')).to eq({ "a" => 3, "b" => 2 })
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(2)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(645)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(1)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(737)
  end
end
