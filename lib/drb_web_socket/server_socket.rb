# frozen_string_literal: true

module DrbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open.
  class ServerSocket
    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
    end
  end
end
