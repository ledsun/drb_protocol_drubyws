# frozen_string_literal: true

module DrbWebSocket
  # A protocol with WebSocket for drb.
  module Protocol
    class << self
      def open(uri, config)
        Socket.new(uri, nil, config)
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
