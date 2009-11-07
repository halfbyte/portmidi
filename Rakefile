require File.join(File.dirname(__FILE__), "lib/portmidi/version")
begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "portmidi"
    gemspec.summary = "An ffi wrapper around the cross platform midi library portmidi"
    gemspec.description = "An ffi wrapper around the cross platform midi library portmidi, part of the portmedia framework"
    gemspec.email = "jan@krutisch.de"
    gemspec.homepage = "http://github.com/halfbyte/midimapper"
    gemspec.authors = ["Jan Krutisch"]
    gemspec.add_dependency('ffi')
    gemspec.version = Portmidi::VERSION
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end