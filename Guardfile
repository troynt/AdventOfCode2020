# A sample Guardfile
# More info at https://github.com/guard/guard#readme

directories %w[challenges]

rspec_opts = {
  all_on_start: false,
  spec_paths: ['challenges']
}

guard :rspec, cmd: 'bundle exec rspec', **rspec_opts do
  watch('challenges/spec_helper.rb') { "challenges" }
  watch(%r{^challenges\/(.+)_spec\.rb$}) { |m| "challenges/#{m[1]}_spec.rb" }
  watch(%r{^challenges\/(.+)\.rb$}) { |m| "challenges/#{m[1]}_spec.rb" }
end