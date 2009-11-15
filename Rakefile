require 'rubygems'
require 'rake'
require File.join(File.dirname(__FILE__), "lib/portmidi/version")

begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "portmidi"
    gemspec.summary = "An ffi wrapper around the cross platform midi library portmidi"
    gemspec.description = "An ffi wrapper around the cross platform midi library portmidi, part of the portmedia framework"
    gemspec.email = "jan@krutisch.de"
    gemspec.homepage = "http://github.com/halfbyte/portmidi"
    gemspec.authors = ["Jan Krutisch"]
    gemspec.version = Portmidi::VERSION
    gemspec.requirements << "Needs portmidi compiled as a dynamic library"
    gemspec.requirements << "On MRI, this needs the ffi gem installed"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Portmidi::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Portmidi #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end