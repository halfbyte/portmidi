module Porttime
  TimerCallback = FFI::Function.new(:void, [:int32, :pointer]) do |timestamp, user_data|
    @timer_callback.call(timestamp, user_data)
  end

  # Start the Porttime timer system
  # * interval is in milliseconds
  # * You can add arbitrary user data that will be given to the callback
  # * the callback block will be called each interval seconds.
  def self.start(interval=20, user_data=nil, &block)
    @timer_callback = block
    Portmidi::PM_Map.Pt_Start(interval, Porttime::TimerCallback, user_data)
  end

  # Get the current time
  # * you can use that to figure out how to properly schedule events into the future
  def self.time
    Portmidi::PM_Map.Pt_Time
  end
end
