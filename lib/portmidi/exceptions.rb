module Portmidi
  class DeviceError < StandardError
    attr_reader :portmidi_error
    def initialize(errnum)
      @portmidi_error = PM_Map.Pm_GetErrorText(errnum)
    end
  end
  
end