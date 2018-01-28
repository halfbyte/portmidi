require 'portmidi/version'
require 'portmidi/pm_map'
require 'portmidi/device'
require 'portmidi/input'
require 'portmidi/output'
require 'portmidi/exceptions'
require 'porttime'

module Portmidi

  def self.devices(rescan = false)
    @@devices = []
    PM_Map.Pm_CountDevices.times do |i|
      di = PM_Map::DeviceInfo.new(PM_Map.Pm_GetDeviceInfo(i))
      @@devices << Device.new(i, di[:input], di[:output], di[:name])
    end
    @@devices
  end

  def self.input_devices
    self.devices.select{|device| device.type == :input }
  end
  def self.output_devices
    self.devices.select{|device| device.type == :output }
  end

  # this is not a very good name, but Portmidi::initialize woulda been a worse idea
  def self.start
    PM_Map.Pm_Initialize
  end

end
