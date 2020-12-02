require 'set'
require 'rspec'

now = Time.now

if now.month == 12 && now.year == 2019
  # RSpec::Core::Runner.run(['challenges', '--tag', "computer"])
  # RSpec::Core::Runner.run(['challenges', '--tag', "day7"])
  # RSpec::Core::Runner.run(['challenges', '--tag', "day11"])
  RSpec::Core::Runner.run(['challenges', '--tag', "day#{now.day}"])
else
  RSpec::Core::Runner.run(['challenges'])
end



nil
