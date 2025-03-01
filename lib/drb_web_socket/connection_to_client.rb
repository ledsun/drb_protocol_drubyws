# frozen_string_literal: true
require_relative "drb_message"

module DRbWebSocket
  # A connection instance from DrbWebSocket::Server#accept.
  class ConnectionToClient
    # DRb::DRbServer#main_loop calls `client.uri` method.
    attr_reader :uri

    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
      @msg = DRbWebSocket::DRbMessage.new(config)
    end

    # Receive a request from the client and return a [object, message, args, block] tuple.
    def recv_request
      @msg.recv_request(@socket)
    end

    #  Send a reply to the client.
    def send_reply(succ, result)
      @msg.send_reply(@socket, succ, result)
    end

    # Close this connection.
    def close
      return unless @socket

      @socket.close
      @socket = nil
    end
  end
end
