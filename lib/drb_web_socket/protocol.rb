# frozen_string_literal: true

module DRbWebSocket
  # A protocol with WebSocket for drb.
  module Protocol
    class << self
      def open(uri, config)
        ConnectionToServer.new(uri, nil, config)
      end

      def open_server(uri, config)
        dummy_socket = IO.new(0)
        Server.new(uri, dummy_socket, config)
      end

      def uri_option(uri, config)
        [uri, config]
      end
    end
  end
end
