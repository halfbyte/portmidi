module Portmidi
  class Input
    def initialize(device_id, buffer_size = 512)
      puts buffer_size
      in_stream_ptr = FFI::MemoryPointer.new(:pointer)
      if (errnum = PM_Map.Pm_OpenInput(in_stream_ptr, device_id, nil, buffer_size, nil, nil)) == 0
        @in_stream = in_stream_ptr.read_pointer
      else
        raise "Could not open Device #{device_id} as output device"
      end
    end
    
    def poll
      PM_Map.Pm_Poll(@in_stream) != 0
    end
    
    def read(buffer_size = 1)
      event_pointer = FFI::MemoryPointer.new(PM_Map::Event, buffer_size)
      read = PM_Map::Pm_Read(@in_stream, event_pointer, buffer_size);
      if read > 0
        events = []
        read.times do |i|
          events << parseEvent(PM_Map::Event.new(event_pointer[i]))
        end
        return events
      elsif read < 0
        raise DeviceError, read, "read failed"
      else
        return nil
      end
    end
    
    # TODO: poll methods etc.
  private
    def parseEvent(event)
      {
        :message => [
          ((event[:message]) & 0xFF),
          (((event[:message]) >> 8) & 0xFF),
          (((event[:message]) >> 16) & 0xFF),
          (((event[:message]) >> 24) & 0xFF)
        ],
        :timestamp => event[:timestamp]
      }
    end
    
  end
end