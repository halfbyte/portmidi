#!/usr/bin/env ruby
require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"lib"))

require 'chars'
require 'portmidi'

include Portmidi

Portmidi::start

devices = Portmidi::devices

puts devices.map(&:to_str)
output = Output.new(5)

output.write_short(0xB0, 0x00, 0x00)

text = "hello world"

loop do
  text.each_char do |char|
    output.write_short(0xB0, 0x00, 0x00)
    Chars.write_by_pixel(char) do |x,y|
      output.write_short(0x90,(0x10 * y + x), 0x03)
    end
    sleep 0.2
  end
end