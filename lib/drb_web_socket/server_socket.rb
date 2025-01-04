# frozen_string_literal: true

module DrbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open.
  class ServerSocket
    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
    end

    # Receive a request from the client and return a [object, message, args, block] tuple.
    def recv_request
      # Ideally, this would be implemented as:
      # @msg.recv_request(stream)
      [Object.new, :message, [], proc {}]
    end
  end
end
