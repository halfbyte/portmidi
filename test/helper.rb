require 'rubygems'
require 'test/unit'
require 'mocha'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'portmidi'

class Test::Unit::TestCase
  def stub_portmidi
    Portmidi::PM_Map.stubs(:CountDevices).returns(2)
    Portmidi::PM_Map.stubs(:Pm_Initialize).returns(false);
    Portmidi::PM_map.stubs(:Pm_GetDeviceInfo).returns({:input => 1, :output => 0, :name => 'TestDevice'})
    Portmidi::PM_map.stubs(:Pm_OpenInput).returns(1)
    Portmidi::PM_map.stubs(:Pm_OpenOutput).returns(2)
    Portmidi::PM_map.stubs(:Pm_Poll).returns(1)
    Portmidi::PM_map.stubs(:Pm_Poll).returns(1)
    Portmidi::PM_map.stubs(:Pm_Read).returns(1)
    Portmidi::PM_Map.stubs(:Pm_WriteShort).returns(1)
    Portmidi::PM_Map.stubs(:Pm_GetErrorText).returns(1)
  end
end
