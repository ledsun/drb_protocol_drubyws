# frozen_string_literal: true

module DrbWebSocket
  # A protocol with WebSocket for drb.
  module Protocol
    class << self
      def open(_uri, _config)
        Client.new
      end

      def open_server(_uri, _config)
        Server.new
      end

      def uri_option(uri, config)
        [uri, config]
      end
    end
  end
end
