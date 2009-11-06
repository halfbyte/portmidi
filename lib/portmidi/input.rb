module Portmidi
  class Input
    def initialize(device_id = 0, buffer_size = 4)
      in_stream_ptr = FFI::MemoryPointer.new(:pointer)
      if (errnum = PM_Map.Pm_OpenInput(in_stream_ptr, device_id, nil, buffer_size, nil, nil)) == 0
        @in_stream = in_stream_ptr.read_pointer
      else
        raise "Could not open Device #{device_id} as output device"
      end
    end
    
    def poll
      
    end
    
    # TODO: poll methods etc.
    
  end
end