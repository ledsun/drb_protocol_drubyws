# frozen_string_literal: true

module DRbWebSocket
  # A protocol with WebSocket for drb.
  module Protocol
    class << self
      def open(uri, config)
        ConnectionToServer.new(uri, nil, config)
      end

      def open_server(uri, config)
        Server.new(uri, nil, config)
      end

      def uri_option(uri, config)
        [uri, config]
      end
    end
  end
end
