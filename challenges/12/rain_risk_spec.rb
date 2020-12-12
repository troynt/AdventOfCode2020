
require_relative 'rain_risk'

describe 'RainRisk', :day12 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    RainRisk.new(lines)
  end

  it "should be able to rotate" do
    ex = with_data('fixtures/example.txt')
    expect(ex.angle).to eq(0)
    ex.exec_cmd("L", 90)
    expect(ex.angle).to eq(90)
    ex.exec_cmd("R", 90)
    expect(ex.angle).to eq(0)

    ex.exec_cmd("R", 360)
    expect(ex.angle).to eq(-360)

    ex.exec_cmd("L", 270)
    expect(ex.angle).to eq(-90)
  end

  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(25)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(521)
  end

  it 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_two).to eq(286)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(22848)
  end
end
