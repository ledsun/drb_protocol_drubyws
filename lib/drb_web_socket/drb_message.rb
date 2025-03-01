# frozen_string_literal: true

require "drb/drb"

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
    rescue StandardError
      raise(DRbConnError, $ERROR_INFO.message, $ERROR_INFO.backtrace)
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

      [ro, msg, argv, block]
    end

    def send_reply(stream, succ, result)
      stream.write(dump(succ))
      stream.write(dump(result, !succ))
    rescue StandardError
      raise(DRbConnError, $ERROR_INFO.message, $ERROR_INFO.backtrace)
    end

    def load(soc)
      begin
        str = soc.gets
      rescue StandardError
        raise(DRb::DRbConnError, $ERROR_INFO.message, $ERROR_INFO.backtrace)
      end
      raise(DRb::DRbConnError, "connection closed") if str.nil?

      DRb.mutex.synchronize do
        Marshal.load(str)
      rescue NameError, ArgumentError
        DRbUnknown.new($ERROR_INFO, str)
      end
    end

    def dump(obj, error = false) = Marshal::dump(obj)
  end
end
