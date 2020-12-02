require 'net/http'
require 'uri'
require "active_support/inflector"
require 'date'
require 'fileutils'
require 'pry'

YEAR = Time.now.year


def get_title(year, day)
  uri = URI.parse("https://adventofcode.com/#{year}/day/#{day}")
  response = Net::HTTP.get_response uri
  _, day, title = response.body.force_encoding(Encoding::UTF_8).match(%r[--- Day (\d+): (.*) ---]).to_a

  title
end

# requires AOC_SESSION environment variable set.
def get_input(year, day)
  if !ENV["AOC_SESSION"]
    return
  end

  uri = URI.parse("https://adventofcode.com/#{year}/day/#{day}/input")

  req = Net::HTTP::Get.new(uri)

  req['Cookie'] = "session=#{ENV["AOC_SESSION"]}"

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(req)


  input = response.body.force_encoding(Encoding::UTF_8)

  input
end

def create_file_if_missing(file_path)
  return if File.exists? file_path

  File.open(file_path, 'w') do |f|
    yield(f)
  end
end


available_challenge_dirs = Set.new (1..25).map { |i| Date.new(YEAR, 12, i) }.select {|x| x <= Date.today }.map(&:day)
existing_challenge_dirs = Set.new Dir.glob('challenges/**').map { |x| x.gsub('challenges/', '').to_i }.select { |x| x > 0 }

missing = (available_challenge_dirs - existing_challenge_dirs)
# missing = (available_challenge_dirs) # uncomment to recreate all

missing.to_a.sort.reverse.each do |day|
  path = File.join(File.dirname(__FILE__), "challenges", "#{day}");
  title = get_title(YEAR, day)

  return if title.nil?

  title_underscored = title.parameterize.gsub(/^[^a-z]+/i, '').underscore
  title_classified = title.gsub(' ', '').gsub(/^[^a-z]+/i, '').classify

  FileUtils.mkdir_p(File.join(path, "fixtures"))

  create_file_if_missing(File.join(path, "#{title_underscored}.rb")) do |f|
    f.puts """
require 'awesome_print'
require 'pry'

# https://adventofcode.com/#{YEAR}/day/#{day}
class #{title_classified}
  def initialize(nums)
    @nums = nums
  end

  def calc_part_one

  end

  def calc_part_two

  end
end
"""
  end

  create_file_if_missing(File.join(path, "#{title_underscored}_spec.rb")) do |f|
    f.puts """
require_relative '#{title_underscored}'

describe '#{title_classified}', :day#{day} do
  def with_data(file_path)
    cur_dir = File.dirname(__FILE__)
    f = File.open(File.join(cur_dir, file_path))
    nums = f.readlines.map(&:to_i)

    #{title_classified}.new(nums)
  end

  skip 'should be able to handle example data for part one' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(0)
  end

  it 'should be able to handle input data for part one' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_one).to eq(0)
  end

  skip 'should be able to handle example data for part two' do
    ex = with_data('fixtures/example.txt')
    expect(ex.calc_part_one).to eq(0)
  end

  skip 'should be able to handle input data for part two' do
    ex = with_data('fixtures/input.txt')
    expect(ex.calc_part_two).to eq(0)
  end
end
"""
  end

  create_file_if_missing(File.join(path, "fixtures", "input.txt")) do |f|
    f.puts get_input(YEAR, day)
  end
end

