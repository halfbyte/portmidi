module Portmidi
  class Device
    attr_reader :name, :device_id, :type
    def initialize(device_id, input, output, name)
      @device_id = device_id
      @type = (input == 1 ? :input : (output == 1 ? :output : :none))
      @type = :bidirectional if @type == :input && output == 1
      @name = name
    end
    
    def open(buffer_size = nil, latency = nil)
      case(@type)
      when :input
        Input.new(@device_id, buffer_size)
      when :output
        Output.new(@device_id, buffer_size, latency)
      when :bidirectional
        [Input.new(@device_id, buffer_size), Output.new(@device_id, buffer_size, latency)]
      else
        raise "this device has no inputs or outputs to open"
      end
    end

    def to_s
      to_str
    end
    
    def to_str
      "#{@device_id}> #{@name} (#{@type})"
    end
    
    def inspect
      "#<Portmidi::Device:#{@device_id} @name=\"#{@name}\", @type=:#{@type}>"
    end
      
    
  end
end