# frozen_string_literal: true

module DrbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open_server.
  class Server
    #  Get the URI for this server.
    attr_reader :uri

    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
    end

    # Accept a new connection to the server.
    # Returns a protocol instance capable of communicating with the client.
    def accept
      ServerSocket.new(@uri, @socket, @config)
    end

    # Close the server connection.
    def close
      return unless @socket

      @socket.close
      @socket = nil
    end
  end
end
