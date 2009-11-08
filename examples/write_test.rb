require 'helper'
messages = [
  {:message => [0x90, 0x33, 0x7F], :timestamp => 0},
  {:message => [0x90, 0x33, 0x00], :timestamp => 0}
]

Portmidi.output_devices.each do |dev|
  puts "%d > %s" % [dev.device_id, dev.name]
end
puts "choose device id"
device_id = gets()

output =  Portmidi::Output.new(device_id.to_i)
output.write(messages)
