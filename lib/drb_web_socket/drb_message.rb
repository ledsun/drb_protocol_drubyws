require 'drb/drb'

module DRbWebSocket
  # Send and receive messages for DRb over WebSocket.
  # Use TextFrame for WebSocket.
  class DRbMessage < DRb::DRbMessage
    def send_request(stream, ref, msg_id, arg, b)
      stream.write(dump(ref.__drbref))
      stream.write(dump(msg_id.id2name))
      stream.write(dump(arg.length))
      arg.each do |e|
        stream.write(dump(e))
      end
      stream.write(dump(b))
    rescue
      raise(DRbConnError, $!.message, $!.backtrace)
    end

    def recv_request(stream)
      ref = load(stream)
      ro = DRb.to_obj(ref)
      msg = load(stream)

      argc = load(stream)
      raise(DRbConnError, "too many arguments") if @argc_limit < argc

      argv = Array.new(argc, nil)
      argc.times do |n|
        argv[n] = load(stream)
      end

      block = load(stream)

      return ro, msg, argv, block
    end

    def send_reply(stream, succ, result)
      stream.write(dump(succ))
      stream.write(dump(result, !succ))
    rescue
      raise(DRbConnError, $!.message, $!.backtrace)
    end

    def load(soc)
      begin
        str = soc.gets
      rescue
        raise(DRb::DRbConnError, $!.message, $!.backtrace)
      end
      raise(DRb::DRbConnError, 'connection closed') if str.nil?
      DRb.mutex.synchronize do
        begin
          Marshal::load(str)
        rescue NameError, ArgumentError
          DRbUnknown.new($!, str)
        end
      end
    end

    def dump(obj, error = false) = Marshal::dump(obj)
  end
end
