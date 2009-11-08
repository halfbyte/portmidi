module Portmidi
  class Output
    
    #
    # open a device with the given ID
    #
    def initialize(device_id = 0, buffer_size = 0, latency = 0)
      out_stream_ptr = FFI::MemoryPointer.new(:pointer)
      if (errnum = PM_Map.Pm_OpenOutput(out_stream_ptr, device_id, nil, buffer_size, nil, nil, latency)) == 0
        @out_stream = out_stream_ptr.read_pointer
      else
        raise Portmidi::DeviceError, errnum, "Could not open Device #{device_id} as output device"
      end
    end
    
    #
    # write a single three byte message
    #
    
    def write_short(status, data1, data2)
      PM_Map.Pm_WriteShort(@out_stream, 0, PM_Map.encode_message(status, data1, data2))
    end
    
    def write(messages)
      buffer = FFI::MemoryPointer.new(PM_Map::Event, messages.length)
      messages.length.times do |i|
        event = PM_Map::Event.new(buffer[i])
        event[:timestamp] = messages[i][:timestamp]
        event[:message] = packEvent(messages[i][:message])
      end
      PM_Map.Pm_Write(@out_stream, buffer, messages.length)
    end
    
    

    # 
    # sends the sysex, the message should be an array of byte values
    # 
    def write_sysex(sysex)
      raise "Invalid Sysex Format" if (sysex.first != 0xF0 || sysex.last != 0xF7)
      msg = FFI::Buffer.alloc_in(:uchar, sysex.length)
      sysex.each_with_index do |sysx, i|
        msg.put_uchar(i, sysx & 0xFF)
      end
      PM_Map.Pm_WriteSysEx(@out_stream, 0, msg)
    end
    
  private
    def packEvent(message)
      ((((message[3] || 0) << 24) & 0xFF000000) | (((message[2] || 0) << 16) & 0xFF0000) | (((message[1] || 0) << 8) & 0xFF00) | ((message[0]) & 0xFF))
    end
    
  end
end