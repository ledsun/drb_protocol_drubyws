# frozen_string_literal: true

require "drb/drb"
require_relative "drb_message"

module DRbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open.
  class ConnectionToServer
    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
      @msg = DRbWebSocket::DRbMessage.new(config)
    end

    # Send a request to +ref+ with the given message id and arguments.
    def send_request(ref, msg_id, arg, block)
      @msg.send_request(@socket, ref, msg_id, arg, block)
    end

    # Receive a reply from the server and return it as a [success-boolean, reply-value] pair.
    def recv_reply
      @msg.recv_reply(@socket)
    end

    # Close this connection.
    def close
      return unless @socket

      @socket.close
      @socket = nil
    end

    # Is this connection still alive?
    def alive?
      return false unless @socket

      true
    end
  end
end
