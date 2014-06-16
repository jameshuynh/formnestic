# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "formnestic"
  gem.homepage = "http://github.com/jameshuynh/formnestic"
  gem.license = "MIT"
  gem.summary = %Q{An extension of formtastic form builder gem}
  gem.description = %Q{An extension of formtastic form builder gem to aids in building nested or association form}
  gem.email = "james@rubify.com"
  gem.authors = ["James"]
  gem.version = File.exist?('VERSION') ? File.read('VERSION') : ""
  # dependencies defined in Gemfile
end
# Jeweler::RubygemsDotOrgTasks.new

desc 'Test the formtastic plugin.'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Test the formtastic inputs.'
RSpec::Core::RakeTask.new('spec:inputs') do |t|
  t.pattern = FileList['spec/inputs/*_spec.rb']
end

desc 'Test the formtastic plugin with specdoc formatting and colors'
RSpec::Core::RakeTask.new('specdoc') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end