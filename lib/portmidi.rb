require 'portmidi/version'
require 'portmidi/pm_map'
require 'portmidi/device'
require 'portmidi/input'
require 'portmidi/output'
require 'portmidi/exceptions'

module Portmidi
  
  def self.devices
    devices = []
    PM_Map.Pm_CountDevices.times do |i|
      di = PM_Map::DeviceInfo.new(PM_Map.Pm_GetDeviceInfo(i))
      devices << Device.new(i, di[:input], di[:output], di[:name])
    end
    devices
  end
  
  # this is not a very good name, but Portmidi::initialize woulda been a worse idea
  def self.start
    PM_Map.Pm_Initialize
  end
  
end
