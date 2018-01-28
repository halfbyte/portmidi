require 'rubygems'
require 'rake'
require File.join(File.dirname(__FILE__), "lib/portmidi/version")

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Portmidi::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Portmidi #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
