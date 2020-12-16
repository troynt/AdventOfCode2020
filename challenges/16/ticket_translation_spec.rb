
require_relative 'ticket_translation'

describe 'TicketTranslation', :day16 do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    lines = f.readlines.map(&:strip)

    TicketTranslation.new(lines)
  end


  it 'should be able to parse tickets' do
    ex = with_data('fixtures/example.txt')
    expect(ex.tickets).to eq(%w(7,1,14 7,3,47 40,4,50 55,2,20 38,6,12).map { |x| x.split(',').map(&:to_i)})
  end

  it 'should be validate ticket' do
    ex = with_data('fixtures/example.txt')
    expect(ex.invalid_ticket?([40,4,50])).to eq([4])
    expect(ex.invalid_ticket?([55,2,20])).to eq([55])
    expect(ex.invalid_ticket?([38,6,12])).to eq([12])
    expect(ex.invalid_ticket?([7,1,14])).to eq([])
  end


  it 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(71)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(29759)
  end

  it 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(1307550234719)
  end
end
