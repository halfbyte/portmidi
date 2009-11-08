require 'ffi'
module Portmidi
  module PM_Map
    extend FFI::Library
    #ffi_lib File.join(File.dirname(__FILE__), 'libportmidi_d')
    ffi_lib 'libportmidi'
    attach_function :Pm_CountDevices, [], :int
    attach_function :Pm_Initialize, [], :void
    attach_function :Pm_GetDeviceInfo,[:int], :pointer
  
    attach_function :Pm_OpenInput, [:pointer, :int, :pointer, :int, :pointer, :pointer], :int
    attach_function :Pm_OpenOutput, [:pointer, :int, :pointer, :int, :pointer, :pointer, :int32], :int
    attach_function :Pm_Poll, [:pointer], :int
    attach_function :Pm_Read, [:pointer, :pointer, :int], :int
    attach_function :Pm_WriteShort, [:pointer, :int32, :int32], :int
    attach_function :Pm_Write, [:pointer, :pointer, :int32], :int
    attach_function :Pm_WriteSysEx, [:pointer, :int32, :buffer_in], :int

    attach_function :Pm_GetErrorText, [:int], :string
  
    #attach_function :Pt_Start, [:int, :pointer, :pointer], :int
  
    class DeviceInfo < FFI::Struct
      layout :struct_version,  :int,
             :midi_api,  :string,
             :name,  :string,
             :input, :int,
             :output, :int,
             :opened, :int
    end
  
    class Event < FFI::Struct
      layout :message, :int32,
             :timestamp, :int32
    end
  
    def self.encode_message(status, data1, data2)
      ((((data2) << 16) & 0xFF0000) | (((data1) << 8) & 0xFF00) | ((status) & 0xFF))
    end  
  end
end
