require 'rubygems'
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'portmidi'

input =  Portmidi.devices[2].open
loop do
  if input.poll
    event = input.read
    if event
      puts event[:message].inspect
    end
  else
    sleep 0.02
  end
end
