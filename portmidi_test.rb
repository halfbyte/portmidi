require 'rubygems'
require 'ffi'

module PM
  extend FFI::Library
  ffi_lib 'libportmidi_d'
  attach_function :Pm_CountDevices, [], :int
  attach_function :Pm_Initialize, [], :void
  attach_function :Pm_GetDeviceInfo,[:int], :pointer
  
  attach_function :Pm_OpenInput, [:pointer, :int, :pointer, :int, :pointer, :pointer], :int
  attach_function :Pm_Poll, [:pointer], :int
  attach_function :Pm_Read, [:pointer, :pointer, :int], :int
  
  
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
  
end

PM.Pm_Initialize
PM.Pm_CountDevices.times do |i|
  di = PM::DeviceInfo.new(PM.Pm_GetDeviceInfo(i))
  puts i, di[:input], di[:output], di[:name]  
end

stream_ptr = FFI::MemoryPointer.new(:pointer)
puts PM.Pm_OpenInput(stream_ptr, 1, nil, 255, nil, nil)
@stream = stream_ptr.read_pointer

loop do
  code = PM.Pm_Poll(@stream)
  if code == 1
    event_ptr = FFI::MemoryPointer.new(:pointer)
    PM.Pm_Read(@stream, event_ptr, 1)
    event = PM::Event.new(event_ptr)
    puts event[:message].inspect
  elsif code == 0
    sleep 0.2
  else
    puts "whoopsie? error: #{code}"
  end
  
end




