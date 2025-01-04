# DrbWebSocket provides a protocol with WebSocket to drb.

module DrbWebSocket
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