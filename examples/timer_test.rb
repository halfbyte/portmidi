require_relative 'helper'
Portmidi.output_devices.each do |dev|
  puts "%d > %s" % [dev.device_id, dev.name]
end
puts "choose device id"
device_id = gets()
output =  Portmidi::Output.new(device_id.to_i)

Porttime.start(500) do |time|
  output.write_short(0x90, 36, 100)
  output.write_short(0x80, 36, 100)
end

sleep 3
