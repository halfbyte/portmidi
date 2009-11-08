require 'helper'
Portmidi.input_devices.each do |dev|
  puts "%d > %s" % [dev.device_id, dev.name]
end
puts "choose device id"
device_id = gets()

input =  Portmidi::Input.new(device_id.to_i)
cnt = 0
data = []
running_sysex = []
sysex_is_on = false
loop do
  begin
    events = input.read(16)
    if events
      events.each do |event|
        
        
        if event[:message][0] == 0xF0
          running_sysex = event[:message]
          sysex_is_on = true
        elsif sysex_is_on
          if event[:message][0] < 0x80
            running_sysex += event[:message]
            if event[:message].include?(0xF7)
              data << running_sysex.flatten
              puts running_sysex.inspect
              sysex_is_on = false
            end
          else
            puts event[:message].inspect
            sysex_is_on = false
            puts "cancelled sysex"
          end
        end
      end
      # data << events
    else
      # puts "poll" if cnt % 10000 == 0
    end
  rescue Portmidi::DeviceError => e
    puts e.portmidi_error
  end
  cnt += 1
  #sleep 0.002
end
