module Portmidi
  class DeviceError < StandardError
    def initialize(errnum)
      @full_message
    end
  end
end