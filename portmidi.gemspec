require_relative 'lib/portmidi/version'
require 'rake'

Gem::Specification.new do |s|
  s.name = "portmidi"
  s.summary = "An ffi wrapper around the cross platform midi library portmidi"
  s.description = "An ffi wrapper around the cross platform midi library portmidi, part of the portmedia framework"
  s.email = "jan@krutisch.de"
  s.homepage = "http://github.com/halfbyte/portmidi"
  s.files = FileList[
    'license.txt',
    'README.rdoc',
    'Rakefile',
    'CHANGELOG.md',
    'lib/**/*.rb',
    'test/**/*.rb'
  ]
  s.authors = ["Jan Krutisch"]
  s.version = Portmidi::VERSION
  s.add_runtime_dependency 'ffi', '~> 1.9'
  s.requirements << "Needs portmidi compiled as a dynamic library"
  s.required_ruby_version = ">= 2.0.0"
end
