require 'helper'
sysex = [0xF0, 00, 12, 0x12, 0xF7]

Portmidi.output_devices.each do |dev|
  puts "%d > %s" % [dev.device_id, dev.name]
end
puts "choose device id"
device_id = gets()

output =  Portmidi::Output.new(device_id.to_i)
output.write_sysex(sysex)
