# frozen_string_literal: true

require_relative "drb_web_socket/version"

module DrbWebSocket
  # DrbWebSocket provides a protocol with WebSocket to drb.
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

  class Client
  end

  class Server
  end
end
