require 'tempfile'
require 'ruby-prof'

def bench(&block)
  profile = RubyProf::Profile.new.profile do
    block.call
  end
  printer = RubyProf::CallStackPrinter.new(profile)

  File.open("bench.html", "w") do |file|
    printer.print(file)
  end

end
