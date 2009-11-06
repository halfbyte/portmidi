module Portmidi
  class Output
    def initialize(device_id = 0, buffer_size = 4, latency = 0)
      out_stream_ptr = FFI::MemoryPointer.new(:pointer)
      if (errnum = PM_Map.Pm_OpenOutput(out_stream_ptr, device_id, nil, buffer_size, nil, nil, latency)) == 0
        @out_stream = out_stream_ptr.read_pointer
      else
        raise Portmidi::DeviceError, errnum, "Could not open Device #{device_id} as output device"
      end
    end
    
    def write_short(status, data1, data2)
      PM_Map.Pm_WriteShort(@out_stream, 0, PM_Map.encode_message(status, data1, data2))
    end
    
  end
end