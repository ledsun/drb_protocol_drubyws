# frozen_string_literal: true

module DRbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open.
  class ServerSocket
    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
      @msg = DRb::DRbMessage.new(config)
    end

    # Receive a request from the client and return a [object, message, args, block] tuple.
    def recv_request
      @msg.recv_request(@socket)
    end

    #  Send a reply to the client.
    def send_reply(succ, result)
      @msg.send_reply(@socket, succ, result)
    end
  end
end
