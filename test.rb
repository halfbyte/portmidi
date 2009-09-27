require 'rubygems'
require 'ffi'

module CF # :nodoc:
  extend FFI::Library
  ffi_lib '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'
  attach_function :CFStringCreateWithCString, [:pointer, :string, :int], :pointer
  attach_function :CFDictionaryGetCount, [:pointer], :int
  attach_function :CFDictionaryGetKeysAndValues, [:pointer, :pointer, :pointer], :int
  attach_function :CFStringGetCString,  [:pointer, :pointer, :int, :int], :int
end

module CoreMidi
  extend FFI::Library
  
  ffi_lib '/System/Library/Frameworks/CoreMIDI.framework/Versions/Current/CoreMIDI'
  
  callback :midi_read_proc, [:pointer, :pointer, :pointer], :void
  
  attach_function :MIDIGetNumberOfDestinations, [], :int
  attach_function :MIDIGetNumberOfSources, [], :int
  attach_function :MIDIGetNumberOfDevices, [], :int
  attach_function :MIDIGetNumberOfExternalDevices, [], :int

  attach_function :MIDIGetDevice, [:int], :int
  attach_function :MIDIGetDestination, [:int], :int
  attach_function :MIDIGetSource, [:int], :int
    
  attach_function :MIDIObjectGetStringProperty, [:int, :pointer, :pointer], :int
  attach_variable :kMIDIPropertyDisplayName, :pointer
  
  attach_function :MIDIClientCreate, [:pointer, :pointer, :pointer, :pointer], :int
  attach_function :MIDIInputPortCreate, [:pointer, :pointer, :midi_read_proc, :pointer, :pointer], :int
  attach_function :MIDIPortConnectSource, [:pointer, :int, :pointer], :int
  attach_function :MIDIPortDisconnectSource, [:pointer, :int], :int
end

puts "%d Devices" % CoreMidi.MIDIGetNumberOfDevices()
puts "%d ExternalDevices" % CoreMidi.MIDIGetNumberOfExternalDevices()
puts "%d Sources" % CoreMidi.MIDIGetNumberOfSources()
puts "%d Destinations" % CoreMidi.MIDIGetNumberOfDestinations()

CoreMidi.MIDIGetNumberOfSources().times do |i|
  ref = CoreMidi.MIDIGetSource(i)

  name_ptr = FFI::MemoryPointer.new :pointer
  
  status = CoreMidi.MIDIObjectGetStringProperty(ref, CoreMidi.kMIDIPropertyDisplayName, name_ptr)
  
  str_ptr = FFI::MemoryPointer.new( :char, 255 )
  
  status = CF.CFStringGetCString(name_ptr.get_pointer(0), str_ptr, 255, 0)
  
  puts str_ptr.read_string
  
end

read_proc = Proc.new do |packet_list, read_proc_ref_con, src_connect_ref_con|
  puts "received some"
end


client_name = CF.CFStringCreateWithCString( nil, "DingsTest", 0 )
client_ptr = FFI::MemoryPointer.new(:pointer)

puts CoreMidi.MIDIClientCreate(client_name, nil, nil, client_ptr)
@client = client_ptr.read_pointer

port_name = CF.CFStringCreateWithCString( nil, "Output", 0 )
ref_con = CF.CFStringCreateWithCString( nil, "Reference", 0 )
port_ptr = FFI::MemoryPointer.new(:pointer)
puts CoreMidi.MIDIInputPortCreate(@client, port_name, read_proc, nil, port_ptr)
@port = port_ptr.read_pointer
@source = CoreMidi.MIDIGetSource(0)
puts CoreMidi.MIDIPortConnectSource(@port, @source, nil)
loop do
  # well
end
puts CoreMidi.MIDIPortDisconnectSource(@port, @source)
